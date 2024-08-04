{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    lsd
  ];
  programs.zsh.shellAliases = {
    ls = "${pkgs.lsd}/bin/lsd";
  };
}
