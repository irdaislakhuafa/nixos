{ pkgs, lib, ... }:
let
  langs = import ../../langs.nix { };
  isEnable = langs.vue;
in
lib.mkIf (isEnable) {
  home.packages = [
    pkgs.vue-language-server
    pkgs.bun
    pkgs.typescript
  ];

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
          "tsconfig.json"
          ".prettierrc.json"
        ];
        language-servers = [
          "vuels"
          # "ts"
        ];
      }
    ];
    language-server = {
      vuels = {
        command = "vue-language-server";
        args = [ "--stdio" ];
        config = {
          typescript = {
            tsdk = "${pkgs.typescript}/lib/node_modules/typescript/lib/";
          };
        };
      };
    };
  };
}
