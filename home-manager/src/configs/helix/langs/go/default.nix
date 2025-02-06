{
  lib,
  pkgs,
  config,
  ...
}:
let
  langs = import ../../langs.nix { };
  isEnable = langs.go;
in
lib.mkIf (isEnable) {
  home.packages = [
    pkgs.gopls
    pkgs.go
    pkgs.gotools
  ];

  home.sessionVariables = {
    GOPATH = "/home/${config.home.username}/go";
    PATH = "$PATH:${config.home.sessionVariables.GOPATH}/bin";
    GOME = "github.com/irdaislakhuafa";
  };

  home.shellAliases = {
    gonit = "go mod init $GOME/$(basename $(pwd))";
    grun = "go run";
  };

  programs.helix.languages = {
    language = [
      {
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
      }
    ];

    language-server = {
      gopls = {
        command = "gopls";
        scope = "source.go";
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
}
