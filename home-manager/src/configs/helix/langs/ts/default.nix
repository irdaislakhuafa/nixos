{
  lib,
  pkgs,
  config,
  ...
}:
let
  langs = import ../../langs.nix { };
  isEnable = langs.ts;
in
lib.mkIf (isEnable) {
  home.packages = [
    pkgs.typescript-language-server
    pkgs.bun
    pkgs.vscode-langservers-extracted
  ];

  programs.helix.languages = {
    language = [
      {
        name = "typescript";
        roots = [
          "package.json"
          "node_modules"
        ];
        language-servers = [
          "ts"
          "vscode-eslint-language-server"
        ];
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
