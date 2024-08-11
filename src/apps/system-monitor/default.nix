{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    glances
  ];
}
