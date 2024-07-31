{ pkgs, ... }: ''
  source ${pkgs.oh-my-zsh}/share/oh-my-zsh/oh-my-zsh.sh

  source ${pkgs.zsh-defer}/share/zsh-defer/zsh-defer.plugin.zsh

  source ${pkgs.zsh-forgit}/share/zsh/zsh-forgit/git-forgit.zsh
  source ${pkgs.zsh-forgit}/share/zsh/zsh-forgit/forgit.plugin.zsh

  source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.zsh
  source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

  source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.zsh
  source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh

  source ${pkgs.zsh-git-prompt}/share/zsh-git-prompt/zshrc.sh

  source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh

  source ${pkgs.zsh-autopair}/share/zsh/zsh-autopair/autopair.zsh

  source ${pkgs.zsh-you-should-use}/share/zsh/plugins/you-should-use/you-should-use.plugin.zsh

  source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-highlight

  source ${pkgs.zsh-autoenv}/share/zsh-autoenv/init.zsh

  source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

  source ${pkgs.deer}/share/zsh/site-functions/deer

  source ${pkgs.fzf-zsh}/share/zsh/plugins/fzf-zsh/fzf-zsh.plugin.zsh
''
