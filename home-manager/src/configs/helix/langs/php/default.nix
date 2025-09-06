{
  lib,
  pkgs,
  config,
  ...
}:
let
  langs = import ../../langs.nix { };
  isEnable = langs.php;
  isEnableBladeSupports = false;
  isUsePhpActor = false;
  isUseIntelephense = true;
in
lib.mkIf (isEnable) {
  home.packages =
    [ pkgs.php ]
    ++ (if (isUseIntelephense) then (with pkgs; [ intelephense ]) else [ ])
    ++ (
      if (isUsePhpActor) then
        (with pkgs; [
          phpactor
          php83Packages.php-codesniffer
          php83Packages.php-cs-fixer
          php83Packages.psalm
        ])
      else
        [ ]
    )
    ++ (if (isEnableBladeSupports) then (with pkgs; [ blade-formatter ]) else [ ]);

  programs.helix.languages = {
    language =
      [
        {
          name = "php";
          language-servers =
            langs.global.lsp
            ++ (if (isUsePhpActor) then [ "phpactor" ] else [ ])
            ++ (if (isUseIntelephense) then [ "intelephense" ] else [ ]);
          indent = {
            tab-width = 4;
            unit = " ";
          };
          auto-format = true;
        }
      ]

      # if blade support enabled
      ++ (
        if (isEnableBladeSupports) then
          [
            {
              name = "blade";
              injection-regex = "blade";
              scope = "source.blade.php";
              language-servers = [ "scls" ];
              file-types = [
                { glob = "*.blade.php"; }
                "blade"
              ];
              formatter = {
                command = "blade-formatter";
                args = [
                  "--write"
                  "--progress"
                  "--indent-inner-html"
                ];
              };
            }
          ]
        else
          [ ]
      );

    language-server = {
      intelephense = {
        command = "intelephense";
        args = [ "--stdio" ];
        scope = "source.php";
        config = rec {
          storagePath = "${config.home.homeDirectory}/.cache/intelephense";
          globalStoragePath = storagePath;
          # licenseKey = ""; # if your have license
          clearCache = false;
        };
      };
      phpactor = {
        command = "phpactor";
        args = [
          "language-server"
          "-vvv"
        ];
        scope = "source.php";
      };
    };
  };

  home.file.".config/phpactor/phpactor.json" = {
    enable = isUsePhpActor;
    text = ''${builtins.toJSON ({
      # disable xdebug for better performance
      "xdebug_disable" = true;

      # disable leading dollar
      "language_server_completion.trim_leading_dollar" = true;
      "language_server_php_cs_fixer.enabled" = true;
      "language_server_php_cs_fixer.bin" = "${pkgs.php83Packages.php-cs-fixer}/bin/php-cs-fixer";
      "php_code_sniffer.enabled" = false;

      # reflections
      "language_server_worse_reflection.inlay_hints.enable" = false;
      "language_server_worse_reflection.inlay_hints.types" = false;
      "language_server_worse_reflection.inlay_hints.params" = false;

      # psalm
      "language_server_psalm.enabled" = true;
      "language_server_psalm.show_info" = true;
      # "language_server_psalm.bin" = "${pkgs.php83Packages.psalm}/bin/psalm";
      "language_server_psalm.bin" = "${pkgs.php83Packages.psalm}/bin/psalm-language-server";
    })}'';
  };
}
