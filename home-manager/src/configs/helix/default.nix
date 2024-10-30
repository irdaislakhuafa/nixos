{ pkgs, lib, ... }:
let
  go = import ./lsp/go.nix { inherit lib; };
  js = import ./lsp/js.nix { inherit lib; };
  ts = import ./lsp/ts.nix { inherit lib; };
in
{
  programs.helix = {
    enable = true;
    defaultEditor = false;
    ignores = [ ];
    languages = {
      language = [
        go.language
        js.language
        ts.language
      ];
      language-server = {
        gopls = go.server;
        js = js.server;
        ts = ts.server;
      };
    };
    settings = import ./settings.nix { };
    themes = import ./themes.nix { };
  };
}
