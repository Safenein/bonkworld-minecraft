#!/bin/bash

# Btrfs Automatic Backup Script
# Creates snapshots and optionally copies to external filesystem

set -euo pipefail

# Configuration
CONFIG_FILE="/etc/btrfs-backup.conf"
LOG_FILE="/var/log/btrfs-backup.log"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Default values
SUBVOLUMES_TO_BACKUP="/,/home"
SNAPSHOT_DIR="/.snapshots"
EXTERNAL_BACKUP_DIR=""
KEEP_SNAPSHOTS=7
KEEP_EXTERNAL_BACKUPS=3

# Load configuration if exists
if [[ -f "$CONFIG_FILE" ]]; then
    source "$CONFIG_FILE"
fi

# Logging function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Create snapshot directory if it doesn't exist
create_snapshot_dir() {
    if [[ ! -d "$SNAPSHOT_DIR" ]]; then
        mkdir -p "$SNAPSHOT_DIR"
        log "Created snapshot directory: $SNAPSHOT_DIR"
    fi
}

# Create btrfs snapshot
create_snapshot() {
    local subvolume="$1"
    local snapshot_name="${subvolume//\//_}_${TIMESTAMP}"
    local snapshot_path="$SNAPSHOT_DIR/$snapshot_name"
    
    if btrfs subvolume snapshot -r "$subvolume" "$snapshot_path"; then
        log "Created snapshot: $snapshot_path"
        echo "$snapshot_path"
    else
        log "ERROR: Failed to create snapshot for $subvolume"
        return 1
    fi
}

# Copy snapshot to external filesystem
copy_to_external() {
    local snapshot_path="$1"
    local snapshot_name=$(basename "$snapshot_path")
    
    if [[ -z "$EXTERNAL_BACKUP_DIR" ]]; then
        log "No external backup directory configured, skipping external backup"
        return 0
    fi
    
    if [[ ! -d "$EXTERNAL_BACKUP_DIR" ]]; then
        log "ERROR: External backup directory does not exist: $EXTERNAL_BACKUP_DIR"
        return 1
    fi
    
    local external_path="$EXTERNAL_BACKUP_DIR/$snapshot_name"
    
    log "Copying snapshot to external filesystem: $external_path"
    if btrfs send "$snapshot_path" | btrfs receive "$EXTERNAL_BACKUP_DIR"; then
        log "Successfully copied snapshot to external filesystem"
    else
        log "ERROR: Failed to copy snapshot to external filesystem"
        return 1
    fi
}

# Cleanup old snapshots
cleanup_snapshots() {
    log "Cleaning up old snapshots (keeping $KEEP_SNAPSHOTS)"
    
    # Get list of snapshots sorted by creation time
    local snapshots=($(ls -1t "$SNAPSHOT_DIR" | tail -n +$((KEEP_SNAPSHOTS + 1))))
    
    for snapshot in "${snapshots[@]}"; do
        local snapshot_path="$SNAPSHOT_DIR/$snapshot"
        if btrfs subvolume delete "$snapshot_path"; then
            log "Deleted old snapshot: $snapshot_path"
        else
            log "ERROR: Failed to delete snapshot: $snapshot_path"
        fi
    done
}

# Cleanup old external backups
cleanup_external_backups() {
    if [[ -z "$EXTERNAL_BACKUP_DIR" ]] || [[ ! -d "$EXTERNAL_BACKUP_DIR" ]]; then
        return 0
    fi
    
    log "Cleaning up old external backups (keeping $KEEP_EXTERNAL_BACKUPS)"
    
    local backups=($(ls -1t "$EXTERNAL_BACKUP_DIR" | tail -n +$((KEEP_EXTERNAL_BACKUPS + 1))))
    
    for backup in "${backups[@]}"; do
        local backup_path="$EXTERNAL_BACKUP_DIR/$backup"
        if btrfs subvolume delete "$backup_path"; then
            log "Deleted old external backup: $backup_path"
        else
            log "ERROR: Failed to delete external backup: $backup_path"
        fi
    done
}

# Main backup function
main() {
    log "Starting btrfs backup process"
    
    create_snapshot_dir
    
    # Process each subvolume
    IFS=',' read -ra SUBVOLS <<< "$SUBVOLUMES_TO_BACKUP"
    for subvol in "${SUBVOLS[@]}"; do
        subvol=$(echo "$subvol" | xargs) # trim whitespace
        
        if [[ ! -d "$subvol" ]]; then
            log "WARNING: Subvolume does not exist: $subvol"
            continue
        fi
        
        log "Processing subvolume: $subvol"
        
        if snapshot_path=$(create_snapshot "$subvol"); then
            copy_to_external "$snapshot_path"
        fi
    done
    
    cleanup_snapshots
    cleanup_external_backups
    
    log "Backup process completed"
}

# Check if running as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" >&2
    exit 1
fi

# Run main function
main "$@"
