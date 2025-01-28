{
  lib,
  pkgs,
  config,
  ...
}:
let
  langs = import ../../langs.nix { };
  isEnable = langs.css;
in
lib.mkIf (isEnable) {
  home.packages = [
    pkgs.vscode-langservers-extracted
  ];

  programs.helix.languages = {
    language = [
      {
        name = "css";
        language-servers = [ "css" ];
        indent = {
          tab-width = 2;
          unit = " ";
        };
      }
    ];

    language-server = {
      css = {
        command = "vscode-css-language-server";
        args = [ "--stdio" ];
        config = {
          provideFormatter = true;
          keepLines = true;
          validate = true;
          format = true;
        };
        scope = "source.css";
      };
    };
  };
}
