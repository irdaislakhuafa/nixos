{ pkgs, ... }: {
  environment.systemPackages = with pkgs;[
    arch-install-scripts
  ];
}
