{
  lib,
  pkgs,
  config,
  ...
}:
let
  langs = import ../../langs.nix { };
  isEnable = langs.markdown;
in
lib.mkIf (isEnable) {
  home.packages = [
    # pkgs.vscode-langservers-extracted
    pkgs.marksman
  ];

  programs.helix.languages = {
    language = [
      {
        name = "markdown";
        language-servers = [
          # "markdown"
          "marksman"
        ];
        indent = {
          tab-width = 2;
          unit = " ";
        };
      }
    ];

    language-server = {
      marksman = {
        command = "marksman";
        config = {
          core = {
            markdown = {
              file_extensions = [
                "md"
                "markdown"
              ];
              glfm_heading_ids.enable = true;
            };
            text_sync = "full";
            title_from_heading = true;
            incremental_references = true;
            paranoid = false;
          };
          code_action = {
            toc.enable = true;
            create_missing_file.enable = true;
          };
          completion = {
            candidates = 50;
            wiki.style = "title-slug";
          };
        };
      };
      # markdown = {
      #   command = "vscode-markdown-language-server";
      #   args = [ "--stdio" ];
      #   config = {
      #     provideFormatter = true;
      #     keepLines = true;
      #     validate = true;
      #     format = true;
      #   };
      #   scope = "source.md";
      # };
    };
  };
}
