{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    gh
    gh-dash
    gh-cal
    gh-eco
  ];
}
