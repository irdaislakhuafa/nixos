{
  description = "NixOS configuration with nixos-unstable channel with specific commit hash";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/d70bd19e0a38ad4790d3913bf08fcbfc9eeca507";
  };

  outputs =
    { nixpkgs, ... }:
    {
      nixosConfigurations = {
        developer = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hardware-configuration.nix
            ./configuration.nix
          ];
        };
      };
    };
}
