{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    fzf
  ];
}
