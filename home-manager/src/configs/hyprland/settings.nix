{ config, ... }: rec{
  isEnableAutoStart = true;
  dirName = "hypr";
  dir = builtins.toPath ~/.config/${dirName};
  wallpaper = rec {
    name = "room.png";
    path = builtins.toPath ./assets/${name};
  };
  locker = {
    image = rec {
      name = "arch_chan_logo.jpg";
      path = builtins.toPath ./assets/${name};
    };
  };
}
