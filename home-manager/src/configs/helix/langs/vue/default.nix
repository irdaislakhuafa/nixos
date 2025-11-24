{ pkgs, lib, ... }:
let
  langs = import ../../langs.nix { };
  isEnable = langs.vue;
in
lib.mkIf (isEnable) {
  home.packages = [ pkgs.vue-language-server ];

  programs.helix.languages = {
    language = [
      {
        name = "vue";
        auto-format = true;
        scope = "source.vue";
        injection-regex = "vue";
        file-types = [ "vue" ];
        roots = [
          "package.json"
          "vue.config.js"
          ".prettierrc.json"
        ];
        language-servers = [
          "vuels"
          "ts"
        ];
      }
    ];
    language-server = {
      vuels = {
        command = "vue-language-server";
        args = [ "--stdio" ];
        config = {
          typescript = {
            tsdk = "./node_modules/typescript/lib";
          };
        };
      };
    };
  };
}
