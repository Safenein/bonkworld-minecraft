{
  description = "A minecraft server flake for Bonk World!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
  };

  outputs = {
    self,
    nixpkgs,
  }: {
    nixosConfigurations = {
      bonkworld = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
        ];
        specialArgs = {inherit self;};
      };
    };
  };
}
