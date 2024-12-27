{ config, ... }: rec{
  isEnableAutoStart = true;
  dirName = "hypr";
  dir = builtins.toPath "/home/i/.config/${dirName}";
  wallpaper = rec {
    name = "room.png";
    path = builtins.toPath ./assets/${name};
  };
  locker = {
    image = rec {
      name = "gintama.png";
      path = builtins.toPath ./assets/${name};
    };
  };
}
