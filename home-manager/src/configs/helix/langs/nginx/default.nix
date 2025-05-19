{ lib, ... }:
let
  langs = import ../../langs.nix { };
  isEnable = langs.nginx;
in
lib.mkIf (isEnable) {
  programs.helix.languages = {
    language = [
      {
        name = "nginx";
        scope = "source.nginx";
        injection-regex = "nginx";
        file-types = [
          { glob = "sites-available/*.conf"; }
          { glob = "sites-enabled/*.conf"; }
          { glob = "nginx.conf"; }
          { glob = "conf.d/*.conf"; }
        ];
        roots = [ "nginx.conf" ];
        comment-token = "#";
        indent = {
          tab-width = 4;
          unit = " ";
        };
        language-servers = [ ] ++ langs.global.lsp;
      }
    ];
  };
}
