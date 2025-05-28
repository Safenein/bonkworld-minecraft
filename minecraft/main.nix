{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nix-minecraft.nixosModules.minecraft-servers
  ];

  config = {
    nixpkgs.overlays = [inputs.nix-minecraft.overlay];

    services.minecraft-servers = {
      enable = true;
      eula = true;

      servers.bonkworld = {
        enable = true;
        package = pkgs.fabricServers.fabric-1_21_5;
        autoStart = true;
        openFirewall = true;
        enableReload = true;
        jvmOpts = "-Xmx4G -Xms2G -XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:+UseZGC";

        serverProperties = {
          motd = "Bienvenue sur Bonk World!";
          difficulty = "normal";
          level-name = "bonkworld";
          enable-command-block = true;
          max-players = 50;
          enforce-secure-profile = false;
          view-distance = 12;
          spawn-protection = 0;
          log-ips = false;
          op-permission-level = 3;
        };

        symlinks = {
          "mods" = with pkgs;
            linkFarmFromDrvs "mods" (
              builtins.attrValues {
                Fabric-API = fetchurl {
                  url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/w6P5mySo/fabric-api-0.125.0%2B1.21.5.jar";
                  sha512 = "159cf97b0869c923e3b7f477db8eefe70e4a4906f3663ac4e9c23e4237bbd0e07d79405de6b323a7a9989c76d33959770ba499abba12c90d64ca710c079b2bc7";
                };
                Ferrite-Core = fetchurl {
                  url = "https://cdn.modrinth.com/data/uXXizFIs/versions/CtMpt7Jr/ferritecore-8.0.0-fabric.jar";
                  sha512 = "131b82d1d366f0966435bfcb38c362d604d68ecf30c106d31a6261bfc868ca3a82425bb3faebaa2e5ea17d8eed5c92843810eb2df4790f2f8b1e6c1bdc9b7745";
                };
                Lithium = fetchurl {
                  url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/VWYoZjBF/lithium-fabric-0.16.2%2Bmc1.21.5.jar";
                  sha512 = "09a68051504bb16069dd6af8901f2bbeadfd08ad5353d8bcc0c4784e814fb293d9197b4fb0a8393be1f2db003cd987a9e4b98391bbe18c50ae181dace20c2fa4";
                };
              }
            );
        };
      };
    };
  };
}
