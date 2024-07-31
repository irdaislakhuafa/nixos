{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lsd
  ];
  environment.shellAliases = {
    ls = "lsd";
  };
}
