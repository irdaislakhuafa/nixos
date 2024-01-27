{config, pkgs, ... }:
{
  # enable home manager
  programs.home-manager.enable = true;

  home.username = "i";
  home.homeDirectory = "/home/i";
  home.stateVersion = "24.05";

  imports = [ ./src/configs/default.nix ];
}
