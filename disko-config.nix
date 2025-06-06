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
              size = "1G";512M
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "fmask=0077"
                  "dmask=0077"
                  "uid=0"
                  "gid=0"
                ];
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
                    mountOptions = ["noatime" "compress=zstd" "discard"];
                  };
                  "@home" = {
                    mountpoint = "/home";
                    mountOptions = ["noatime" "compress=zstd" "discard"];
                  };
                  "@var" = {
                    mountpoint = "/var";
                    mountOptions = ["noatime" "compress=zstd" "discard"];
                  };
                  "@var_log" = {
                    mountpoint = "/var/log";
                    mountOptions = ["noatime" "compress=zstd" "discard"];
                  };
                  "@opt" = {
                    mountpoint = "/opt";
                    mountOptions = ["noatime" "compress=zstd" "discard"];
                  };
                  "@tmp" = {
                    mountpoint = "/tmp";
                    mountOptions = ["noatime" "compress=zstd" "discard"];
                  };
                  "@srv" = {
                    mountpoint = "/srv";
                    mountOptions = ["noatime" "compress=zstd" "discard"];
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
