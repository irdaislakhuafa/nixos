{ config, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableGlobalCompInit = true;
    enableBashCompletion = true;
    loginShellInit =
      let
        home = config.home.homeDirectory;
        promptNum = "\${(%):-%n}.zsh";
      in
      ''
        # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
         # Initialization code that may require console input (password prompts, [y/n]
         # confirmations, etc.) must go above this block; everything else may go below.
         if [[ -r "${home}/.cache/p10k-instant-prompt-${promptNum}" ]]; then
           source "${home}/.cache/p10k-instant-prompt-${promptNum}.zsh"
         fi

         # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
         [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      '';
  };
}
