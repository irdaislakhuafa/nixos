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
  ];

  programs.helix.languages = {
    language = [
      {
        name = "javascript";
        roots = [
          "package.json"
          "node_modules"
        ];
        language-servers = [ "js" ];
        indent = {
          tab-width = 4;
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
