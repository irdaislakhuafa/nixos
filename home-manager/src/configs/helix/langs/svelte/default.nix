{ lib, pkgs, ... }:
let
  langs = import ../../langs.nix { };
  isEnable = langs.svelte;

in
lib.mkIf (isEnable) {
  home.packages = [
    pkgs.bun
    pkgs.typescript
    pkgs.svelte-language-server
  ];

  programs.helix.languages = {
    language = [
      {
        name = "svelte";
        scope = "source.svelte";
        injection-regex = "svelte";
        file-types = [ "svelte" ];
        indent = {
          tab-width = 2;
          unit = "  ";
        };
        block-comment-tokens = {
          start = "<!--";
          end = "-->";
        };
        language-servers = [
          "svelteserver"
          "html"
          "emmet"
        ] ++ langs.global.lsp;
      }
    ];
    language-server = {
      svelteserver = {
        command = "svelteserver";
        args = [ "--stdio" ];
        config = {
          configuration = {
            typescript = {
              inlayHints.parameterTypes.enabled = true;
              inlayHints.variableTypes.enabled = true;
              inlayHints.propertyDeclarationTypes.enabled = true;
              inlayHints.functionLikeReturnTypes.enabled = true;
              inlayHints.enumMemberValues.enabled = true;
              inlayHints.parameterNames.enabled = "all";
            };
            javascript = {
              inlayHints.parameterTypes.enabled = true;
              inlayHints.variableTypes.enabled = true;
              inlayHints.propertyDeclarationTypes.enabled = true;
              inlayHints.functionLikeReturnTypes.enabled = true;
              inlayHints.enumMemberValues.enabled = true;
              inlayHints.parameterNames.enabled = "all";
            };
          };
        };
      };
    };
  };
}
