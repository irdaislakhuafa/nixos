{
  pkgs,
  lib,
  ...
}:
let
  isEnable = true;
in
lib.mkIf (isEnable) {
  home.packages = [ pkgs.pcre ];
  programs.fish = {
    enable = true;
    shellInit = ''
      # fish config
      set --universal pure_separate_prompt_on_error true;
      set --universal pure_symbol_ssh_prefix "<=>"
      set --universal pure_enable_nixdevshell true
      set --universal pure_show_jobs true
    '';
    plugins = with pkgs; [
      {
        name = "fzf-fish";
        src = fishPlugins.fzf-fish.src;
      }
      {
        name = "forgit";
        src = fishPlugins.forgit.src;
      }
      {
        name = "async-prompt";
        src = fishPlugins.async-prompt.src;
      }
      {
        name = "autopair";
        src = fishPlugins.autopair.src;
      }
      {
        name = "fish-you-should-use";
        src = fishPlugins.fish-you-should-use.src;
      }
      {
        name = "plugin-git";
        src = fishPlugins.plugin-git.src;
      }
      {
        name = "git-emojis";
        src = fetchFromGitHub {
          owner = "gazorby";
          repo = "fish-git-emojis";
          rev = "a7fb5f3483618a8b72acfdc01394be04bcf50bf6";
          sha256 = "ibejS321XVOq+jco0eTPRDm8sjxGvO52H89FSGirbVY=";
        };
      }
      {
        name = "pure";
        src = fetchFromGitHub {
          owner = "pure-fish";
          repo = "pure";
          rev = "28447d2e7a4edf3c954003eda929cde31d3621d2";
          sha256 = "8zxqPU9N5XGbKc0b3bZYkQ3yH64qcbakMsHIpHZSne4=";
        };
      }
      {
        name = "fish-insulter";
        src = fetchFromGitHub {
          owner = "Alaz-Oz";
          repo = "fish-insulter";
          rev = "4c0f22798a7e41f670d606158a06a6fc317f151d";
          sha256 = "fLG0brTA6FFG+MJHDOHCsr9nQUIBgnvLbH4RZaQ1Dm0=";
        };
      }
      {
        name = "fifc";
        src = fishPlugins.fifc.src;
      }
    ];
  };
}
