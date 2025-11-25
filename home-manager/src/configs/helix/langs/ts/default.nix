{
  lib,
  pkgs,
  ...
}:
let
  langs = import ../../langs.nix { };
  isEnable = langs.ts;
  features = {
    tsx = {
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
    pkgs.vtsls
  ] ++ (if (features.tsx.enable) then features.tsx.pkgs else [ ]);

  programs.helix.languages = {
    language =
      [
        {
          name = "typescript";
          roots = [
            "package.json"
            "node_modules"
          ];
          language-servers = [
            "vtsls"
            "vscode-eslint-language-server"
            "emmet"
          ] ++ langs.global.lsp;
          indent = {
            tab-width = 2;
            unit = " ";
          };
          scope = "source.ts";
        }
      ]
      ++ (
        if (features.tsx.enable) then
          [
            {
              name = "tsx";
              scope = "source.tsx";
              injection-regex = "(tsx)";
              # language-id = "typescriptreact";
              file-types = [ "tsx" ];
              roots = [
                "package.json"
                "tsconfig.json"
                "node_modules"
              ];
              comment-token = "//";
              block-comment-tokens = {
                start = "/*";
                end = "*/";
              };
              language-servers = [
                # "ts"
                "vtsls"
                "vscode-eslint-language-server"
                "scls"
                "emmet"
                "tailwind"
              ] ++ langs.global.lsp;
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
      ts = {
        command = "typescript-language-server";
        args = [ "--stdio" ];
        config = {
          provideFormatter = true;
          format = {
            semicolon = "insert";
            convertTabsToSpaces = true;
          };
          referencesCodeLens = {
            enabled = true;
          };
          plugins = [
            {
              name = "@vue/typescript-plugin";
              location = "${pkgs.vue-language-server}/bin/vue-language-server";
              languages = [ "vue" ];
            }
          ];
        };
      };
      vtsls = {
        command = "vtsls";
        args = [ "--stdio" ];
        config = {
          hostInfo = "helix";
          plugins = [
            {
              name = "@vue/typescript-plugin";
              location = "${pkgs.vue-language-server}/bin/vue-language-server";
              languages = [ "vue" ];
            }
          ];
          typescript = {
            updateImportsOnFileMove.enabled = "always";
            suggest.completeFunctionCalls = true;
            tsserver.enableTracing = true;
            inlayHints.parameterNames.enabled = "all";
            inlayHints.parameterTypes.enabled = true;
            inlayHints.variableTypes.enabled = true;
            inlayHints.propertyDeclarationTypes.enabled = true;
            inlayHints.functionLikeReturnTypes = true;
            inlayHints.enumMemberValues.enabled = true;
            format.enable = false;
            format.semicolons = "remove";
            preferences.importModuleSpecifier = "non-relative";
            preferences.importModuleSpecifierEnding = "auto";
            tsserver.pluginPaths = [
              "typescript-plugin-css-modules"
              "./node_modules"
            ];
          };
        };
      };
      emmet = lib.mkIf (features.tsx.enable) {
        command = "emmet-language-server";
        args = [ "--stdio" ];
      };
    };
  };
}
