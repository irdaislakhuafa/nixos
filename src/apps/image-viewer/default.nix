{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    imv
    imagemagick
  ];
}
