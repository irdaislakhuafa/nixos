{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lunarvim
    lazygit
  ];
  home.file.".config/lvim/config.lua" = {
    enable = true;
    text = builtins.readFile ./config.lua;
  };
}
