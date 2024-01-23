{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    gh
    gh-dash
    gh-cal
  ];
}
