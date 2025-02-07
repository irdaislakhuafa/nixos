{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # google-chrome
    brave
  ];
}
