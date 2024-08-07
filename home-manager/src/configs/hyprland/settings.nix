{ config, ... }: {
  isEnableAutoStart = true;
  dir = builtins.toPath ~/.config/hypr;
  wallpaper = {
    path = builtins.toPath ./assets/three.jpg;
  };
}
