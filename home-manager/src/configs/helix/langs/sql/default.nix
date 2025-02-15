{
  lib,
  pkgs,
  ...
}:
let
  langs = import ../../langs.nix { };
  isEnable = langs.sql;
in
lib.mkIf (isEnable) {
  home.packages = [ ];

  programs.helix.languages = {
    language = [
      {
        name = "sql";
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
