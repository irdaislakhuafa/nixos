{ config, ... }: rec{
  isEnableAutoStart = true;
  dirName = "hypr";
  dir = builtins.toPath ~/.config/${dirName};
  wallpaper = rec {
    name = "three.jpg";
    path = builtins.toPath ./assets/${name};
  };
  locker = {
    image = rec {
      name = "nixos_logo_plain.png";
      path = builtins.toPath ./assets/${name};
    };
  };
}
