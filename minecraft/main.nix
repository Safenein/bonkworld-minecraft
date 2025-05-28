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
    services.minecraft-servers.servers.bonkworld = {
      enable = true;
      package = pkgs.fabricServers.fabric-1_21_5;
      eula = true;
      worldName = "BonkWorld";
      jvmOpts = "-Xmx4G -Xms2G -XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:+UseZGC";
    };
  };
}
