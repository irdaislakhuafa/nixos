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
        scope = "source.env";
        indent = {
          tab-width = 2;
          unit = " ";
        };
        file-types = [
          { glob = "*.env"; }
          { glob = ".env.*"; }
          { glob = "*.env.*"; }
          ".env"
        ];
      }
    ];

    language-server = { };
  };
}
