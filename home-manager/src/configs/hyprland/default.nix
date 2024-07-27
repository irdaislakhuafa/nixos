{ config, lib, pkgs, ... }:
let
  hyprlandConfigDir = "~/.config/hypr";
  wallpaperPath = builtins.toPath ./assets/wallpaper.png;
  hyprlandAutoStart = import ./configs/modules/autostart.nix { inherit config pkgs; };
  hyprlandConfig = hyprlandAutoStart + import ./configs/default.nix { };
in
{
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.extraConfig = hyprlandConfig;
  wayland.windowManager.hyprland.systemd.variables = [ "--all" ];
  home.activation = {
    script = ''
      cp -rv ${wallpaperPath} ${hyprlandConfigDir}
    '';
  };
}
