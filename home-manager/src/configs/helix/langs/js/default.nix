{
  lib,
  pkgs,
  config,
  ...
}:
let
  langs = import ../../langs.nix { };
  isEnable = langs.js;
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
        name = "javascript";
        roots = [
          "package.json"
          "node_modules"
        ];
        language-servers = [ "js" "vscode-eslint-language-server" "scls" "emmet" ];
        indent = {
          tab-width = 2;
          unit = " ";
        };
      }
    ];

    language-server = {
      js = {
        command = "typescript-language-server";
        args = [ "--stdio" ];
        config = {
          provideFormatter = true;
        };
        scope = "source.js";
      };
    };
  };
}
