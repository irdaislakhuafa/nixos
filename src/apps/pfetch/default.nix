{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    pfetch
  ];
}
