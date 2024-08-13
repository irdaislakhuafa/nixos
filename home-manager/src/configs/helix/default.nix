{ pkgs, lib, ... }:
let
  isEnable = true;
in
lib.mkIf isEnable {
  programs.helix = {
    enable = true;
    defaultEditor = false;
    ignores = [ ];
    languages = {
      language = [
        {
          name = "go";
          auto-format = true;
          roots = [ "go.mod" "go.sum" "go.work" ];
          comment-token = "//";
        }
      ];
      language-server = {
        gopls = {
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
    };
    settings = {
      theme = "base16";
      editor = {
        line-number = "relative";
        lsp = {
          display-messages = true;
        };
      };
    };
    themes = { };
  };
}
