{pkgs, ...}: {
  # System basics
  system.stateVersion = "25.05";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Network
  networking.hostName = "minecraft-server";
  networking.networkmanager.enable = false;
  networking.useNetworkd = true;
  networking.useDHCP = false;
  systemd.network = {
    enable = true;
    networks."10-wan" = {
      matchConfig.Name = "en*";
      networkConfig.DHCP = "ipv4";
    };
  };

  # User configuration
  users.users.safenein = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager"];
    shell = pkgs.bash;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC7aUaa8QLaEMT1tSPyX667xftPGOBTJ2pWY+zPSMzHeeNgzL7tkhEX2YbLL3c0qinEffHkzOXVpbY0EDbtAoRYd0YY+o3u8QXtlYC944nR3GRW2nkOp0Yag55/Efv/OofjfKg9PTjRKEF7gNI1BuMFqhtDQX0RkP3zjSYG0kgksv2I4w3OLWVVKqKPmjIcxpe9/6zzkyaxxK131TCFI0eARGGHh5u9QeUo9wc+Jn+PlzeF5pE/nnWeG3u0YJnmo5osoesoI1x85+0/nlj/6atvZpBFhUqAChOqy/kXH+Ge3Gng54soJU3b7xIV9aNgkuFZ1uK/pnag5qokVkDT8S9Sf+K+qc2GxxX0dKH3QVx1J+JeL/kbhQuLW0NVT7pRA/arXGv9d+1FGmhcA37nybQrEinXewrf+qKAs5+t7diI8sLsFMMYj786jr5O88othkkuIgJZCbOSVjFj7Q52tPPYov1EGTY0O+Wd47dGe9t0MEgG1AKFwb4G40YVhEv6iaA2kM+KB+Jb0UXd4XMV3Xu6FvtehYV7vLdWohVDCKL99wFIZjSVcl0PoaFezmMLLxvJHapnX+2RrdRTVEXCN6dS/aL7gJ3JEh7c/EFdeytOGR2Eed3Q/k06P3n+1/RrqKpAm5xTQc4HZK79SPOWWwZuoeE8wGjoc5hK9R/UwKK6iQ== safenein@kribin"
    ];
  };

  # Disable root login completely
  users.users.root.hashedPassword = "!";

  # SSH Configuration - Hardened
  services.openssh = {
    enable = true;
    ports = [22];
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      KbdInteractiveAuthentication = false;
      PermitEmptyPasswords = false;
      AllowUsers = ["safenein"];
      Protocol = 2;
      X11Forwarding = false;
      MaxAuthTries = 3;
      ClientAliveInterval = 300;
      ClientAliveCountMax = 2;
      Compression = false;
      TCPKeepAlive = false;
      AllowAgentForwarding = false;
      AllowStreamLocalForwarding = false;
      AuthenticationMethods = "publickey";
    };
    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };

  # Power Management - Aggressive power saving
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
    powertop.enable = true;
  };

  # CPU scaling and power management
  services.thermald.enable = true;
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };

  # Security hardening
  security = {
    # Sudo configuration
    sudo = {
      enable = true;
      execWheelOnly = true;
      wheelNeedsPassword = true;
    };

    # Disable polkit for headless server
    polkit.enable = false;

    # AppArmor
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
    };
  };

  # Kernel hardening
  boot.kernel.sysctl = {
    # Network security
    "net.ipv4.ip_forward" = 0;
    "net.ipv4.conf.all.send_redirects" = 0;
    "net.ipv4.conf.default.send_redirects" = 0;
    "net.ipv4.conf.all.accept_redirects" = 0;
    "net.ipv4.conf.default.accept_redirects" = 0;
    "net.ipv4.conf.all.accept_source_route" = 0;
    "net.ipv4.conf.default.accept_source_route" = 0;
    "net.ipv4.conf.all.log_martians" = 1;
    "net.ipv4.conf.default.log_martians" = 1;
    "net.ipv4.icmp_echo_ignore_broadcasts" = 1;
    "net.ipv4.icmp_ignore_bogus_error_responses" = 1;
    "net.ipv4.tcp_syncookies" = 1;

    # Memory protection
    "kernel.dmesg_restrict" = 1;
    "kernel.kptr_restrict" = 2;
    "kernel.yama.ptrace_scope" = 1;

    # File system protection
    "fs.protected_hardlinks" = 1;
    "fs.protected_symlinks" = 1;
    "fs.suid_dumpable" = 0;
  };

  # Disable unnecessary services
  services.avahi.enable = false;
  services.printing.enable = false;
  hardware.alsa.enable = false;
  hardware.pulseaudio.enable = false;

  # Minimal package set
  environment.systemPackages = with pkgs; [
    vim
    htop
    iotop
    nethogs
    tcpdump
    fail2ban
  ];

  # Fail2ban for SSH protection
  services.fail2ban = {
    enable = true;
    maxretry = 3;
    ignoreIP = [
      "127.0.0.0/8"
      "10.0.0.0/8"
      "192.168.0.0/16"
    ];
    bantime = "1h";
    jails = {
      ssh = {
        settings = {
          port = "ssh";
          filter = "sshd";
          logPath = "/var/log/auth.log";
          maxRetry = 3;
        };
      };
    };
  };

  # Automatic updates for security
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    channel = "nixos-25.05";
    dates = "daily";
    randomizedDelaySec = "30min";
  };

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Optimize nix store
  nix.settings.auto-optimise-store = true;

  # Journald configuration for space saving
  services.journald.extraConfig = ''
    SystemMaxUse=100M
    RuntimeMaxUse=50M
    MaxRetentionSec=1week
  '';

  # Disable X11 completely
  services.xserver.enable = false;

  # File system optimizations for SSD
  fileSystems."/".options = ["noatime" "nodiratime" "discard"];

  # Swap configuration (minimal)
  swapDevices = [];
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;
  };

  # Time zone (adjust as needed)
  time.timeZone = "Europe/Paris";

  # Locale settings
  i18n.defaultLocale = "en_US.UTF-8";
}
