{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lsd
  ];
  environment.shellAliases =
    let
      options = ''--header --git --group-dirs=first --gitsort --extensionsort --classify'';
    in
    {
      lsd = "lsd ${options}";
      ls = "lsd";
      tree = "lsd --tree";
    };
}
