{ pkgs, ... }: rec {
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

  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.enableBashCompletion = true;

  programs.zsh.syntaxHighlighting = {
    enable = true;
    highlighters = [ "main" ];
  };

  programs.zsh.autosuggestions.enable = true;
  programs.zsh.autosuggestions.async = true;

  programs.zsh.ohMyZsh.enable = true;
  programs.zsh.ohMyZsh.plugins = [
    "git"
    "zsh-autosuggestions"
    "fast-syntax-highlighting"
    "fzf-tab"
  ];
  programs.zsh.ohMyZsh.cacheDir = "/tmp";

  programs.zsh.enableLsColors = true;
  programs.zsh.zsh-autoenv.enable = true;
}
