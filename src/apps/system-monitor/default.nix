{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    glances
    htop
    btop
  ];
}
