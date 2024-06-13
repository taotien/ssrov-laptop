{
  description = "flakey laptops";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    disko,
  }: {
    nixosConfigurations.ssrov = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      # specialArgs = {inherit inputs;};
      modules = [
        nixos-hardware.nixosModules.common-cpu-amd
        nixos-hardware.nixosModules.common-gpu-amd
        nixos-hardware.nixosModules.common-pc-laptop
        nixos-hardware.nixosModules.common-pc-laptop-ssd
        disko.nixosModules.disko
        ./disko.nix
        ./system.nix
        ./user.nix
      ];
    };
  };
}
