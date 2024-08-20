{ pkgs, ... }: {
  environment.systemPackages = with pkgs;[
    tty-share
  ];
}
