{
  lib,
  pkgs,
  ...
}:
let
  langs = import ../../langs.nix { };
  isEnable = langs.env;
in
lib.mkIf (isEnable) {
  home.packages = [ ];

  programs.helix.languages = {
    language = [
      {
        name = "env";
        language-servers = [ "scls" ];
        indent = {
          tab-width = 2;
          unit = " ";
        };
      }
    ];

    language-server = { };
  };
}
