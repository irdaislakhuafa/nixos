{
  config,
  lib,
  pkgs,
  ...
}:
let
  isEnable = true;
  settings = import ./settings.nix { inherit config pkgs; };
  styles = import ./styles.nix { };
  activeStyle = styles.glassy_night;
  hyprlandAutoStart = import ./configs/modules/autostart.nix { inherit config pkgs; };
  hyprlandConfig = (import ./configs/default.nix { activeStyle = activeStyle; }) + hyprlandAutoStart;
in
if (isEnable) then
  {
    imports = [
      ./services/default.nix
      ./hyprlock.nix
      ./hypridle.nix
      ./scripts.nix
    ];

    home.packages = [
      pkgs.bc # basic calculator
    ];

    wayland.windowManager.hyprland.enable = settings.isEnableAutoStart;
    wayland.windowManager.hyprland.extraConfig = hyprlandConfig;
    wayland.windowManager.hyprland.systemd.variables = [ "--all" ];
    home.file.".config/${settings.dirName}/wallpaper.png".source = settings.wallpaper.path;
  }
else
  { }
