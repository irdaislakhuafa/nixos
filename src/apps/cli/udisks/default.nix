{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    udisks
  ];
}
