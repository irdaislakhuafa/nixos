{ pkgs, ... }: ''  
  source ${pkgs.zsh-defer}/share/zsh-defer/zsh-defer.plugin.zsh
  
  source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

  zsh-defer source ${pkgs.oh-my-zsh}/share/oh-my-zsh/oh-my-zsh.sh

  zsh-defer source ${pkgs.zsh-forgit}/share/zsh/zsh-forgit/git-forgit.zsh
  zsh-defer source ${pkgs.zsh-forgit}/share/zsh/zsh-forgit/forgit.plugin.zsh

  zsh-defer source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.zsh
  zsh-defer source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

  zsh-defer source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.zsh
  zsh-defer source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh

  zsh-defer source ${pkgs.zsh-git-prompt}/share/zsh-git-prompt/zshrc.sh

  zsh-defer source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh

  zsh-defer source ${pkgs.zsh-autopair}/share/zsh/zsh-autopair/autopair.zsh

  zsh-defer source ${pkgs.zsh-you-should-use}/share/zsh/plugins/you-should-use/you-should-use.plugin.zsh

  zsh-defer source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-highlight

  zsh-defer source ${pkgs.zsh-autoenv}/share/zsh-autoenv/init.zsh

  zsh-defer source ${pkgs.fzf-zsh}/share/zsh/plugins/fzf-zsh/fzf-zsh.plugin.zsh

  # for aws completion
  zsh-defer complete -C "${pkgs.awscli2}/bin/aws_completer" aws

  # the fuck plugin
  zsh-defer eval $(thefuck --alias)
''
