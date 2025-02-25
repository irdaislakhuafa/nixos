{ ... }: rec {
  home.file.".config/rofi/config.rasi" = {
    enable = true;
    text = ''${builtins.readFile ./configs/config.rasi}'';
  };
}
