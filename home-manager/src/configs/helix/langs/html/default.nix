{
  lib,
  pkgs,
  config,
  ...
}:
let
  langs = import ../../langs.nix { };
  isEnable = langs.html;
in
lib.mkIf (isEnable) {
  home.packages = [
    pkgs.vscode-langservers-extracted
  ];

  programs.helix.languages = {
    language = [
      {
        name = "html";
        language-servers = [ "html" ];
        indent = {
          tab-width = 2;
          unit = " ";
        };
      }
    ];

    language-server = {
      html = {
        command = "vscode-html-language-server";
        args = [ "--stdio" ];
        config = {
          provideFormatter = true;
          keepLines = true;
          validate = true;
          format = true;
        };
        scope = "source.html";
      };
    };
  };
}
