{ pkgs, ... }: {
  environment.systemPackages = with pkgs;[
    ranger
    yazi
  ];

  programs.yazi.enable = true;
  environment.shellAliases = {
    "this" = "yazi .";
  };
}
