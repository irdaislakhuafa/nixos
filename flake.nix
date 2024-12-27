{
  description = "NixOS configuration with nixos-unstable channel with specific commit hash";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/d70bd19e0a38ad4790d3913bf08fcbfc9eeca507";
    home-manager.url = "github:nix-community/home-manager/35b98d20ca8f4ca1f6a2c30b8a2c8bb305a36d84";
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        developer = nixpkgs.lib.nixosSystem {
          system = system;
          modules = [
            ./hardware-configuration.nix
            ./configuration.nix
            home-manager.nixosModules.home-manager
          ];
        };
      };

      homeConfigurations = {
        i = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = system;
            config.allowUnfree = true;
          };
          modules = [
            ./home-manager/home.nix
            {
              home = rec {
                username = "i";
                homeDirectory = "/home/${username}";
                stateVersion = "25.05";
              };
            }
          ];
        };
      };
    };
}
