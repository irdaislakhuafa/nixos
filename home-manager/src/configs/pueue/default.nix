{ pkgs, config, ... }:
let
  isEnable = true;
in
{
  services.pueue = {
    enable = isEnable;
    settings = {
      default_parallel_tasks = 10;
    };
  };
  programs.zsh.initExtra = ''
    eval $(${pkgs.pueue}/bin/pueue completion zsh);
  '';
}
