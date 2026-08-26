{ config, pkgs, ... }:
rec {
  isEnableAutoStart = true;
  dirName = "hypr";
  dir = builtins.toPath "${config.home.homeDirectory}/.config/${dirName}";
  wallpaper = rec {
    name = "wallpaper.png";
    # path = builtins.toPath ./assets/${name};
    path = "${pkgs.hyprland}/share/hypr/wall2.png";
  };
  locker = {
    image = rec {
      name = "eh.jpeg";
      path = builtins.toPath ./assets/${name};
    };
  };
}
