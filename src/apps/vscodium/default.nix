{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    vscodium
  ];
}
