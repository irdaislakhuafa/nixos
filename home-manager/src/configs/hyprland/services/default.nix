{
  pkgs,
  lib,
  config,
  ...
}:
let
  settings = import ../settings.nix { inherit config pkgs; };
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
      ExecStart = "${pkgs.swaybg}/bin/swaybg --mode fill -i ${settings.wallpaper.path}";
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
      ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.clipse}/bin/clipse -wl-store";
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
