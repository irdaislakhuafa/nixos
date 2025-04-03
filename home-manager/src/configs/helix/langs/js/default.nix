{
  lib,
  pkgs,
 ...
}:
let
  langs = import ../../langs.nix { };
  isEnable = langs.js;
  features = {
    jsx = {
      enable = true;
      pkgs = [
        pkgs.emmet-language-server
      ];
    };
  };
in
lib.mkIf (isEnable) {
  home.packages = [
    pkgs.typescript-language-server
    pkgs.bun
    pkgs.vscode-langservers-extracted
  ] ++ (if (features.jsx.enable) then features.jsx.pkgs else [ ]);

  programs.helix.languages = {
    language =
      [
        {
          name = "javascript";
          roots = [
            "package.json"
            "node_modules"
          ];
          scope = "source.js";
          language-servers = [
            "js"
            "vscode-eslint-language-server"
            "scls"
            "emmet"
          ];
          indent = {
            tab-width = 2;
            unit = " ";
          };
        }
      ]
      ++ (
        if (features.jsx.enable) then
          [
            {
              name = "jsx";
              scope = "source.jsx";
              injection-regex = "(jsx)";
              # language-id = "typescriptreact";
              file-types = [ "jsx" ];
              roots = [
                "package.json"
                "node_modules"
              ];
              comment-token = "//";
              block-comment-tokens = {
                start = "/*";
                end = "*/";
              };
              language-servers = [
                "ts"
                "vscode-eslint-language-server"
                "scls"
                "emmet"
              ];
              indent = {
                tab-width = 2;
                unit = "";
              };
            }
          ]
        else
          [ ]
      );
    language-server = {
      js = {
        command = "typescript-language-server";
        args = [ "--stdio" ];
        config = {
          provideFormatter = true;
        };
      };
    };
  };
}
