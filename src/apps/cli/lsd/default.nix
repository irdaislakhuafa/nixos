{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    lsd
  ];
  environment.shellAliases = {
    ls = "${pkgs.lsd}/bin/lsd";
  };
}
