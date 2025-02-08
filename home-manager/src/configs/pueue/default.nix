{ pkgs, config, ... }:
let
  isEnable = true;
  pueueCompletionFile = ".config/pueue/completions.zshrc";
in
{
  services.pueue = {
    enable = isEnable;
    settings = {
      default_parallel_tasks = 10;
    };
  };
  home.file.".config/pueue/completions.zshrc" = {
    enable = isEnable;
    source = (
      pkgs.runCommand "pueue_completions"
        {
          buildInputs = [ pkgs.pueue ];
          shell = pkgs.zsh;
        }
        ''
          ${pkgs.pueue}/bin/pueue completions zsh > $out;
        ''
    );
  };

  programs.zsh.initExtra = ''source ${config.home.homeDirectory}/${pueueCompletionFile}'';
}
