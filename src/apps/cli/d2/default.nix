{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ d2 ];
}
