{config, pkgs, ... }:
{
  # enable home manager
  programs.home-manager.enable = true;

  home.username = "i";
  home.homeDirectory = "/home/i";
  home.stateVersion = "24.05";

  wayland.windowManager.hyprland.settings = {
    bind = [
      "$mainMod, RETURN, exec, alacritty -o font.size=12"
    ];
  };
}
