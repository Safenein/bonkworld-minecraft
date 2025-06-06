{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1"; # Adjust based on your actual device
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot/efi";
                mountOptions = [
                  "fmask=0022"
                  "dmask=0022"
                ];
              };
            };
            boot = {
              size = "1G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/boot";
              };
            };
            swap = {
              size = "4G"; # Adjust based on your needs
              content = {
                type = "swap";
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = ["-f"];
                subvolumes = {
                  "@" = {
                    mountpoint = "/";
                    mountOptions = ["noatime" "nodiratime" "discard"];
                  };
                  "@home" = {
                    mountpoint = "/home";
                    mountOptions = ["noatime" "nodiratime" "discard"];
                  };
                  "@var" = {
                    mountpoint = "/var";
                    mountOptions = ["noatime" "nodiratime" "discard"];
                  };
                  "@var_log" = {
                    mountpoint = "/var/log";
                    mountOptions = ["noatime" "nodiratime" "discard"];
                  };
                  "@opt" = {
                    mountpoint = "/opt";
                    mountOptions = ["noatime" "nodiratime" "discard"];
                  };
                  "@tmp" = {
                    mountpoint = "/tmp";
                    mountOptions = ["noatime" "nodiratime" "discard"];
                  };
                  "@srv" = {
                    mountpoint = "/srv";
                    mountOptions = ["noatime" "nodiratime" "discard"];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
