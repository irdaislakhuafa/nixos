{config, pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      "$mainMod, RETURN, exec, alacritty -o font.size=12"
    ];
  };
}
