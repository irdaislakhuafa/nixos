{ config, pkgs, ... }: {
  programs.home-manager.enable = true;

  home.username = "i";
  home.homeDirectory = "/home/i";
  home.stateVersion = "24.05";
  home.enableNixpkgsReleaseCheck = false;
  imports = import ../importer.nix { dir = builtins.toPath ./src; };
}
