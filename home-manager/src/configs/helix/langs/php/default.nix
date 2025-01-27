{
  lib,
  pkgs,
  config,
  ...
}:
let
  langs = import ../../langs.nix { };
  isEnable = langs.php;
in
lib.mkIf (isEnable) {
  home.packages = [
    pkgs.intelephense
    pkgs.php
    pkgs.phpactor
    pkgs.php83Packages.php-codesniffer
  ];

  programs.helix.languages = {
    language = [
      {
        name = "php";
        language-servers = [
          "phpactor"
          "intelephense"
        ];
        indent = {
          tab-width = 4;
          unit = " ";
        };
        auto-format = true;
      }
    ];

    language-server = {
      intelephense = {
        command = "intelephense";
        args = [ "--stdio" ];
        scope = "source.php";
      };
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
      "php_code_sniffer.enabled" = true;
      "php_code_sniffer.bin" = "${pkgs.php83Packages.php-codesniffer}/bin/phpcbf";
      "language_server_worse_reflection.inlay_hints.enable" = true;
      "language_server_worse_reflection.inlay_hints.types" = false;
      "language_server_worse_reflection.inlay_hints.params" = true;
    })}'';
  };
}
