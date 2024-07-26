{ config, pkgs, ... }: {
  programs.home-manager.enable = true;

  home.username = "i";
  home.homeDirectory = "/home/i";
  home.stateVersion = "24.05";
  home.enableNixpkgsReleaseCheck = false;

  imports = [ ./src/configs/default.nix ];
}
