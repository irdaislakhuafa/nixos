{ config, ... }: rec{
  isEnableAutoStart = true;
  dirName = "hypr";
  dir = builtins.toPath "/home/i/.config/${dirName}";
  wallpaper = rec {
    name = "three.jpg";
    path = builtins.toPath ./assets/${name};
  };
  locker = {
    image = rec {
      name = "eh.jpeg";
      path = builtins.toPath ./assets/${name};
    };
  };
}
