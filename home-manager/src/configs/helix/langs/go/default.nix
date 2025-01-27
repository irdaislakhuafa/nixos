{ lib, pkgs, ... }:
let
  isEnable = true;
in
lib.mkIf (isEnable) {
  home.packages = [
    pkgs.gopls
  ];

  programs.helix.languages = {
    language = {
      name = "go";
      auto-format = true;
      roots = [
        "go.mod"
        "go.sum"
        "go.work"
      ];
      comment-token = "//";
      block-comment-tokens = {
        start = "/*";
        end = "*/";
      };
      language-servers = [ "gopls" ];
      indent = {
        tab-width = 2;
        unit = " ";
      };
      formatter = {
        command = "goimports";
      };
    };
    language-server = {
      command = "gopls";
      config = {
        gofumpt = true;
        local = "goimports";
        semanticTokens = true;
        staticcheck = true;
        verboseOutput = true;
        analyses = {
          fieldalignment = true;
          nilness = true;
          unusedparams = true;
          unusedwrite = true;
          useany = true;
        };
        usePlaceholders = true;
        completeUnimported = true;
        hints = {
          assignVariableType = true;
          compositeLiteralFields = true;
          compositeLiteralTypes = true;
          constantValues = true;
          functionTypeParameters = true;
          parameterNames = true;
          rangeVariableTypes = true;
        };
      };
    };
  };
}
