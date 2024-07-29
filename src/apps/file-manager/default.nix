{ pkgs, ... }: {
  environment.systemPackages = with pkgs;[
    ranger
    yazi
  ];
}
