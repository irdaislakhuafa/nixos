{ pkgs, lib, ... }:
let
  go = import ./lsp/go.nix { };
in
{
  programs.helix = {
    enable = true;
    defaultEditor = false;
    ignores = [ ];
    languages = {
      language = [
        go.language
      ];
      language-server = {
        gopls = go.server;
      };
    };
    settings = {
      theme = "dark_plus";
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
