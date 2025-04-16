{ pkgs, lib, ... }:
let
  langs = import ../../langs.nix { };
  isEnable = langs.rust;
in
lib.mkIf (isEnable) {
  home.packages = [ pkgs.rustup pkgs.gcc ];

  programs.helix.languages = {
    language = [
      {
        name = "rust";
        scope = "source.rust";
        injection-regex = "rs|rust";
        file-types = [ "rs" ];
        roots = [
          "Cargo.toml"
          "Cargo.lock"
        ];
        shebangs = [
          "rust-script"
          "cargo"
        ];
        auto-format = true;
        comment-tokens = [
          "//"
          "///"
          "//!"
        ];
        block-comment-tokens = [
          {
            start = "/*";
            end = "*/";
          }
          {
            start = "/**";
            end = "*/";
          }
          {
            start = "/*!";
            end = "*/";
          }
        ];
        language-servers = [
          "rust-analyzer"
          "scls"
        ];
        indent = {
          tab-width = 4;
          unit = "    ";
        };
        persistent-diagnostic-sources = [
          "rustc"
          "clippy"
        ];
      }
    ];
    language-server = {
      rust-analyzer = {
        command = "rust-analyzer";
        config = {
          inlayHints = {
            bindingModeHints.enable = true;
            closingBraceHints.minLines = 10;
            closureReturnTypeHints.enable = "with_block";
            discriminantHints.enable = "fieldless";
            lifetimeElisionHints.enable = "skip_trivial";
            typeHints.hideClosureInitialization = false;
          };
        };
      };
    };
  };
}
