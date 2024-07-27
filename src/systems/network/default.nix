{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    iwd
  ];

  networking.hostName = "developer";

  networking.wireless.iwd = {
    package = pkgs.iwd;
    enable = true;
    settings = {
      Settings = {
        AutoConnect = true;
      };
      Network = {
        EnableIPv6 = true;
        RoutePriorityOffset = 300;
      };
    };
  };
  services.resolved.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;
  services.blueman.enable = true;
  hardware.pulseaudio.extraModules = with pkgs;[
    pulseaudio-modules-bt
  ];
}
