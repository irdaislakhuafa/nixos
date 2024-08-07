{ ... }: {
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
      Restart = "always";
    };
  };

}
