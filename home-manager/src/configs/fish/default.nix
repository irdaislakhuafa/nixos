{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.fish = {
    enable = true;
    vendor = {
      completions = {
        enable = true;
      };
      config = {
        enable = true;
      };
      functions = {
        enable = true;
      };
    };
    plugins = with pkgs.fishPlugins; [
      fzf-fish.src
    ];
  };
}
