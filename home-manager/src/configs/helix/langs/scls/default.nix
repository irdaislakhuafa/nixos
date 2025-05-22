{
  lib,
  pkgs,
  inputs,
  ...
}:
let
  langs = import ../../langs.nix { };
  isEnable = langs.scls;
in
lib.mkIf (isEnable) {
  home.packages = [
    inputs.scls.defaultPackage.${pkgs.system}
  ];

  programs.helix.languages = {
    language = [
      {
        name = "stub";
        scope = "text.stub";
        file-types = [ ];
        shebangs = [ ];
        roots = [ ];
        auto-format = false;
        language-servers = [ ] ++ langs.global.lsp;
      }
    ];
    language-server = {
      scls = {
        command = "simple-completion-language-server";
        config = {
          max_completion_items = 100; # set max completion results len for each group: words, snippets, unicode-input
          feature_words = true; # enable completion by word
          feature_snippets = true; # enable snippets
          snippets_first = true; # completions will return before snippets by default
          snippets_inline_by_word_tail = true; # suggest snippets by WORD tail, for example text `xsq|` become `x^2|` when snippet `sq` has body `^2`
          feature_unicode_input = true; # enable "unicode input"
          feature_paths = true; # enable path completion
          citation = true;
          feature_citations = true; # enable citation completion (only on `citation` feature enabled)
        };
      };
    };
  };
}
