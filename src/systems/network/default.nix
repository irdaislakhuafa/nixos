{ pkgs, config, ... }: {
  environment.systemPackages = with pkgs; [
    iwd
    openvpn
    wirelesstools
    linux-wifi-hotspot
    haveged
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
  services.haveged.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id.startsWith("net.connman.iwd") && subject.isInGroup("${config.users.users.i.group}")) {
        return polkit.Result.YES;
      }
    })
  '';
}
