{ config, lib, pkgs, ... }:
let
  hyprlandConfigDir = builtins.toPath ~/.config/hypr;
  wallpaperPath = builtins.toPath ./assets/three.jpg;
  hyprlandAutoStart = import ./configs/modules/autostart.nix { inherit config pkgs; };
  hyprlandConfig = (import ./configs/default.nix { }) + hyprlandAutoStart;
  hyprlandSystem = (import ../../../../src/apps/window-manager/hyprland/default.nix { inherit lib pkgs config; });
in
{
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.extraConfig = hyprlandConfig;
  wayland.windowManager.hyprland.systemd.variables = [ "--all" ];
  home.activation = {
    script = ''cp -rv ${wallpaperPath} ${hyprlandConfigDir}/wallpaper.png'';
  };

  systemd.user.services.swaybg = lib.mkIf hyprlandSystem.programs.hyprland.enable {
    Unit = {
      Description = "Set wallpaper for Hyprland Window Manager";
      PartOf = "graphical-session.target";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.swaybg}/bin/swaybg -i ${hyprlandConfigDir}/wallpaper.png";
      Restart = "on-failure";
    };
  };

  systemd.user.services.clipse = lib.mkIf hyprlandSystem.programs.hyprland.enable {
    Unit = {
      Description = "Save clipboard histories in Wayland";
      PartOf = "graphical-session.target";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.clipse}/bin/clipse -listen-shell";
      Restart = "on-failure";
    };
  };
}
