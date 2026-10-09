{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    swayimg
    imagemagick
    ghostscript
  ];
}
