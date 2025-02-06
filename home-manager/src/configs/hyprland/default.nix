{ config, lib, pkgs, ... }:
let
  settings = import ./settings.nix { inherit config; };
  hyprlandAutoStart = import ./configs/modules/autostart.nix { inherit config pkgs; };
  hyprlandConfig = (import ./configs/default.nix { }) + hyprlandAutoStart;
in
{
  imports = [
    ./services/default.nix
    ./hyprlock.nix
    ./hypridle.nix
  ];

  home.packages = [
    pkgs.bc # basic calculator
  ];

  wayland.windowManager.hyprland.enable = settings.isEnableAutoStart;
  wayland.windowManager.hyprland.extraConfig = hyprlandConfig;
  wayland.windowManager.hyprland.systemd.variables = [ "--all" ];
  home.file.".config/${settings.dirName}/wallpaper.png".source = settings.wallpaper.path;
}
