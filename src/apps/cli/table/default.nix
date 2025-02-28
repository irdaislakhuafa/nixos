{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    tv
  ];
}
