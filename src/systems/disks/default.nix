{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    udisks
  ];
  services.udisks2.enable = true;
  services.udisks2.mountOnMedia = false;
}
