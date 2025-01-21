{ pkgs, ... }: {
  environment.systemPackages = with pkgs;[
    # lazysql
  ];
}
