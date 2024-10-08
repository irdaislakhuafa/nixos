{ pkgs, lib, ... }: {
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
          block-comment-tokens = {
            start = "/*";
            end = "*/";
          };
          language-servers = [ "gopls" ];
          indent = {
            tab-width = 2;
            unit = " ";
          };
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
        line-number = "absolute";
        lsp = {
          display-messages = true;
        };
        auto-format = true;
      };
    };
    themes = { };
  };
}
