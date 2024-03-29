{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    zsh
    oh-my-zsh
    zsh-defer
    zsh-forgit
    zsh-vi-mode
    zsh-fzf-tab
    zsh-git-prompt
    zsh-completions
    zsh-nix-shell
    zsh-autopair
    zsh-you-should-use
    zsh-fast-syntax-highlighting
    zsh-autoenv
    zsh-powerlevel10k
    deer
  ];

  programs.nix-index.enableZshIntegration = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    syntaxHighlighting = {
      enable = true;
    };
    autosuggestions = {
      enable = true;
      async = true;
    };
    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
        "zsh-autosuggestions"
        "fast-syntax-highlighting"
        "fzf-tab"
      ];
      cacheDir = "/tmp";
    };
    enableLsColors = true;
    zsh-autoenv = {
      enable = true;
    };
  };
}
