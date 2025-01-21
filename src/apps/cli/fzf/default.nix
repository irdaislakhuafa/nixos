{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    fzf
  ];
  environment.variables = {
    FZF_DEFAULT_OPTS = "--layout=reverse -m";
  };
}
