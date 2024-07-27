{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    psmisc
  ];
}
