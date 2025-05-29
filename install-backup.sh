#!/bin/bash

# Installation script for btrfs backup system

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing btrfs backup system..."

# Check if running as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" >&2
    exit 1
fi

# Copy backup script
cp "$SCRIPT_DIR/scripts/btrfs-backup.sh" /usr/local/bin/
chmod +x /usr/local/bin/btrfs-backup.sh
echo "Installed backup script to /usr/local/bin/btrfs-backup.sh"

# Copy configuration file
if [[ ! -f /etc/btrfs-backup.conf ]]; then
    cp "$SCRIPT_DIR/config/btrfs-backup.conf" /etc/
    echo "Installed configuration file to /etc/btrfs-backup.conf"
else
    echo "Configuration file already exists at /etc/btrfs-backup.conf"
fi

# Copy systemd files
cp "$SCRIPT_DIR/systemd/btrfs-backup.service" /etc/systemd/system/
cp "$SCRIPT_DIR/systemd/btrfs-backup.timer" /etc/systemd/system/
echo "Installed systemd service and timer files"

# Reload systemd
systemctl daemon-reload

# Enable and start timer
systemctl enable btrfs-backup.timer
systemctl start btrfs-backup.timer

echo "Btrfs backup system installed and enabled!"
echo "Edit /etc/btrfs-backup.conf to customize settings"
echo "Check status with: systemctl status btrfs-backup.timer"
echo "View logs with: journalctl -u btrfs-backup.service"
