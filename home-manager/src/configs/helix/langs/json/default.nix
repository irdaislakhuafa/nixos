{
  lib,
  pkgs,
  ...
}:
let
  langs = import ../../langs.nix { };
  isEnable = langs.json;
in
lib.mkIf (isEnable) {
  home.packages = [
    pkgs.vscode-langservers-extracted
  ];

  programs.helix.languages = {
    language = [
      {
        name = "json";
        language-servers = [ "json" ] ++ langs.global.lsp;
        indent = {
          tab-width = 2;
          unit = " ";
        };
      }
    ];

    language-server = {
      json = {
        command = "vscode-json-language-server";
        args = [ "--stdio" ];
        config = {
          provideFormatter = true;
          keepLines = true;
          validate = true;
          format = true;
        };
        scope = "source.json";
      };
    };
  };
}
