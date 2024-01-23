{pkgs, ...}: 
{
  environment.systemPackages = with pkgs; [
    lsd
  ];
}
