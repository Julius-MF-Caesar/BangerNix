{
  description = "Modular NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in {
        nixosConfigurations = {
          BangerNix = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
              ./hosts/BangerNix.nix
              ./modules/hardware.nix
              ./modules/user.nix
              ./modules/gaming.nix
              ./modules/productivity.nix
              ./modules/desktop.nix
            ];
          };
        };
      });
}
