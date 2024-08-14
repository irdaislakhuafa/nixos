{ pkgs, ... }: {
  environment.systemPackages = with pkgs;[
    ranger
  ];

  programs.yazi.enable = true;
  environment.shellAliases = {
    "this" = "yazi .";
  };
}
