{ ... }: {
  environment.variables = {
    NIXPKGS_ALLOW_UNFREE = "1";
    NIXOS_OZONE_WL = "1";
  };
  environment.shellAliases = {
    x = "exit";
    c = "clear";
  };
  environment.shellInit = ''
    export EDITOR="nvim";
  '';
}
