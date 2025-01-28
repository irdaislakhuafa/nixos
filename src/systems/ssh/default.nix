{ pkgs, ... }: {
  environment.systemPackages = with pkgs;[
    openssh
    sshfs
    sshx
    sshed
  ];
  services.openssh.enable = true;
}
