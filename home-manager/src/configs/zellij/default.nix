{ pkgs, ... }:
{
  home.packages = [ pkgs.zellij ];
  home.file.".config/zellij/config.kdl" = {
    enable = true;
    text = builtins.readFile ./config.kdl;
  };
  home.file.".config/zellij/layouts/naked.kdl" = {
    enable = true;
    text = builtins.readFile ./layouts/naked.kdl;
  };
}
