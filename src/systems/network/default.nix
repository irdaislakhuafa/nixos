{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    iwd
  ];

  networking.hostName = "developer";

  # services.iwd.enable = true;
  services.resolved.enable = true;
}
