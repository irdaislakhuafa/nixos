{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    imv
    imagemagick
    ghostscript
  ];
}
