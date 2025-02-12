{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lsd
  ];
  environment.shellAliases =
    let
      options = ''--header --git --group-dirs=first --gitsort --extensionsort'';
    in
    {
      lsd = "lsd ${options}";
      ls = "lsd";
    };
}
