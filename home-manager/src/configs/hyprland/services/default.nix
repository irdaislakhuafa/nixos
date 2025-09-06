{
  pkgs,
  lib,
  config,
  ...
}:
let
  settings = import ../settings.nix { inherit config; };
in
{
  systemd.user.services.swaybg = lib.mkIf settings.isEnableAutoStart {
    Unit = {
      Description = "Set wallpaper for Hyprland Window Manager";
      PartOf = "graphical-session.target";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.swaybg}/bin/swaybg --mode fill -i ${settings.dir}/wallpaper.png";
      Restart = "on-failure";
    };
  };

  systemd.user.services.clipse = lib.mkIf settings.isEnableAutoStart {
    Unit = {
      Description = "Save clipboard histories in Wayland";
      PartOf = "graphical-session.target";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.clipse}/bin/clipse -listen-shell";
      Restart = "always";
    };
  };

  systemd.user.services.hyprnotify = lib.mkIf settings.isEnableAutoStart {
    Unit = {
      Description = "Notification daemon for Hyprland";
      PartOf = "graphical-session.target";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      Restart = "always";
      ExecStart = "${pkgs.hyprnotify}/bin/hyprnotify";
    };
  };
}
