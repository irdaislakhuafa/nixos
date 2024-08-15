{ pkgs, ... }:
let
  plugins = import ./plugins/default.nix { inherit pkgs; };
in
rec {
  environment.systemPackages = with pkgs; [
    zsh
    zsh-defer
    zsh-powerlevel10k
    oh-my-zsh
    zsh-forgit
    zsh-vi-mode
    zsh-fzf-tab
    fzf-zsh
    zsh-git-prompt
    zsh-completions
    zsh-nix-shell
    zsh-autopair
    zsh-you-should-use
    zsh-fast-syntax-highlighting
    zsh-autoenv
  ];

  programs.nix-index.enableZshIntegration = true;

  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.shellInit = ''
    export ZSH_DISABLE_COMPFIX=true;
  '';
  programs.zsh.enableBashCompletion = true;
  programs.zsh.interactiveShellInit = plugins;

  programs.zsh.syntaxHighlighting = {
    enable = true;
    highlighters = [ "main" ];
  };

  programs.zsh.autosuggestions.enable = true;
  programs.zsh.autosuggestions.async = true;

  programs.zsh.ohMyZsh.enable = true;
  programs.zsh.ohMyZsh.cacheDir = "/tmp";

  programs.zsh.enableLsColors = true;
  programs.zsh.zsh-autoenv.enable = true;
}
