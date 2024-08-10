{ config, lib, pkgs, ... }:
let
  settings = import ./settings.nix { inherit config; };
  hyprlandAutoStart = import ./configs/modules/autostart.nix { inherit config pkgs; };
  hyprlandConfig = (import ./configs/default.nix { }) + hyprlandAutoStart;
  hyprlandSystem = (import ../../../../src/apps/window-manager/hyprland/default.nix { inherit lib pkgs config; });
in
{
  imports = [
    ./services/default.nix
    ./hyprlock.nix
  ];

  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.extraConfig = hyprlandConfig;
  wayland.windowManager.hyprland.systemd.variables = [ "--all" ];
  home.file.".config/${settings.dirName}/wallpaper.png".source = settings.wallpaper.path;
}
