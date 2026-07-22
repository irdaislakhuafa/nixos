{ pkgs, ... }:
let
  baseDir = ".config/zellij";
in
{
  home.packages = [ pkgs.zellij ];
  home.file."${baseDir}/config.kdl" = {
    enable = true;
    text = builtins.readFile ./config.kdl;
  };
  home.file."${baseDir}/layouts/naked.kdl" = {
    enable = true;
    text = builtins.readFile ./layouts/naked.kdl;
  };
  home.file."${baseDir}/layouts/tabbed.kdl" = {
    enable = true;
    text = builtins.readFile ./layouts/tabbed.kdl;
  };

  # plugins
  home.file."${baseDir}/plugins/room.wasm" = {
    enable = true;
    source = pkgs.fetchurl {
      url = "https://github.com/rvcas/room/releases/latest/download/room.wasm";
      sha256 = "1lbjq3wipw1is8zcpb8kbk6yvyq5g9c608c6fpxnh93n1fj87d4h";
    };
  };
}
