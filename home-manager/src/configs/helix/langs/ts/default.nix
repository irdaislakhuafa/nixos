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
    pkgs.typescript-language-server
    pkgs.bun
  ];

  programs.helix.languages = {
    language = [
      {
        name = "typescript";
        roots = [
          "package.json"
          "node_modules"
        ];
        language-servers = [ "ts" ];
        indent = {
          tab-width = 4;
          unit = " ";
        };
      }
    ];

    language-server = {
      ts = {
        command = "typescript-language-server";
        args = [ "--stdio" ];
        config = {
          provideFormatter = true;
        };
        scope = "source.ts";
      };
    };
  };
}
