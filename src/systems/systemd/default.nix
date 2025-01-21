{ pkgs, ... }: {
  environment.systemPackages = with pkgs;[
    sysz
  ];
}
