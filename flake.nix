{
  description = "NixOS configuration with nixos-unstable channel with specific commit hash";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/9755fc6210088c24e6a0d95d484776c6dcad4e3d";
    home-manager.url = "github:nix-community/home-manager/35b98d20ca8f4ca1f6a2c30b8a2c8bb305a36d84";

    # simple completion language server, used for helix
    scls = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:estin/simple-completion-language-server";
    };

    # iwd menu with rofi
    iwmenu = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:e-tho/iwmenu";
    };
  };

  outputs =
    { self, ... }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        developer = inputs.nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hardware-configuration.nix
            ./configuration.nix
            inputs.home-manager.nixosModules.home-manager
          ];
          specialArgs = { inherit inputs; };
        };
      };

      homeConfigurations = {
        i = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = import inputs.nixpkgs {
            inherit system;
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
          extraSpecialArgs = { inherit inputs; };
        };
      };
    };
}
