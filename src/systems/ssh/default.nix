{ pkgs, ... }: {
  environment.systemPackages = with pkgs;[
    openssh
    sshfs
    sshx
  ];
  services.openssh.enable = true;
}
