{ config, ... }: rec{
  isEnableAutoStart = true;
  dirName = "hypr";
  dir = builtins.toPath ~/.config/${dirName};
  wallpaper = {
    path = builtins.toPath ./assets/three.jpg;
  };
}
