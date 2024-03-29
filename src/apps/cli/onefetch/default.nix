{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    onefetch
  ];
}
