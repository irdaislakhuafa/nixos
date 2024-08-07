{ pkgs, ... }: {
  environment.systemPackages = with pkgs;[
    openssh
    sshfs
  ];
  services.openssh.enable = true;
}
