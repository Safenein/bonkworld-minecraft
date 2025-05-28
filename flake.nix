{
  description = "A minecraft server flake for Bonk World!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: {
    nixosConfigurations = {
      bonkworld = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
          ./minecraft/main.nix
        ];
        specialArgs = {
          inherit self;
          inherit inputs;
        };
      };
    };
  };
}
