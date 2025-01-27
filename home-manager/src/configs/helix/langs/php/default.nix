{
  lib,
  pkgs,
  config,
  ...
}:
let
  isEnable = true;
in
lib.mkIf (isEnable) {
  home.packages = [
    pkgs.intelephense
    pkgs.php
  ];

  programs.helix.languages = {
    language = [
      {
        name = "php";
        roots = [
          "composer.json"
          "composer.lock"
          ".env"
        ];
        language-servers = [ "php" ];
        indent = {
          tab-width = 2;
          unit = " ";
        };
      }
    ];

    language-server = {
      php = {
        command = "intelephense";
        args = [ ];
        scope = "source.php";
      };
    };
  };
}
