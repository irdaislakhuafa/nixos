{
  lib,
  pkgs,
  config,
  ...
}:
let
  langs = import ../../langs.nix { };
  isEnable = langs.css;
  features = {
    tailwind = {
      enable = true;
      pkgs = [ pkgs.tailwindcss-language-server ];
    };
  };
in
lib.mkIf (isEnable) {
  home.packages = [
    pkgs.vscode-langservers-extracted
  ] ++ (if (features.tailwind.enable) then features.tailwind.pkgs else [ ]);

  programs.helix.languages = {
    language = [
      {
        name = "css";
        language-servers = [
          "css"
          "scls"
          "tailwind"
        ];
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
      tailwind = {
        command = "tailwindcss-language-server";
        args = [ "--stdio" ];
        config = {};
      };
    };
  };
}
