{ config, ... }:
{
  programs.zsh = {
    enable = false;
    enableCompletion = true;
    initExtra =
      let
        cacheDir = "${config.home.homeDirectory}/.cache/";
        suffix = "\${(%):-%n}";
      in
      ''
        # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
        # Initialization code that may require console input (password prompts, [y/n]
        # confirmations, etc.) must go above this block; everything else may go below.
        if [[ -r "${cacheDir}/p10k-instant-prompt-${suffix}.zsh" ]]; then
          source "${cacheDir}/p10k-instant-prompt-${suffix}.zsh"
        fi

        # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      '';
  };
}
