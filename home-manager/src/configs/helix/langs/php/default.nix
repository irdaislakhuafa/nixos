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
    # pkgs.intelephense
    pkgs.php
    pkgs.phpactor
  ];

  programs.helix.languages = {
    language = [
      {
        name = "php";
        language-servers = [ "phpactor" ];
        indent = {
          tab-width = 2;
          unit = " ";
        };
      }
    ];

    language-server = {
      #   php = {
      #     command = "intelephense";
      #     args = [ ];
      #     scope = "source.php";
      #   };
      phpactor = {
        command = "phpactor";
        args = [
          "language-server"
        ];
        scope = "source.php";
      };
    };
  };

  home.file.".config/phpactor/phpactor.json" = {
    enable = true;
    text = ''${builtins.toJSON ({
      "language_server_completion.trim_leading_dollar" = true;
      "language_server_php_cs_fixer.enabled" = true;
    })}'';
  };
}
