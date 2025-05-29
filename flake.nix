{
  description = "A minecraft server flake for Bonk World!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    disko.url = "github:nix-community/disko";
  };

  outputs = {
    self,
    nixpkgs,
    disko,
    ...
  } @ inputs: {
    nixosConfigurations = {
      bonkworld = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
          ./minecraft/main.nix
          ./disko-config.nix
          inputs.nix-minecraft.nixosModules.minecraft-servers
          disko.nixosModules.disko
          {
            nixpkgs.overlays = [inputs.nix-minecraft.overlay];
            nixpkgs.config.allowUnfree = true;
          }
        ];
        specialArgs = {
          inherit self;
          inherit inputs;
        };
      };
    };
  };
}
