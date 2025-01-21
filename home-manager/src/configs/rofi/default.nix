{ pkgs, config, ... }: rec {
  # TODO: configure it later
  # programs.rofi = {
  #   enable = true;
  #   pass = {
  #     extraConfig = ''${builtins.readFile ./configs/config.rasi}'';
  #   };
  # };
  home.file.".config/rofi/config.rasi" = {
    enable = true;
    text = ''${builtins.readFile ./configs/config.rasi}'';
  };
}
