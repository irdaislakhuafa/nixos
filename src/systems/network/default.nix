{
  pkgs,
  config,
  lib,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    iwd
    openvpn
    wirelesstools
    # linux-wifi-hotspot
    bluetuith
    impala
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
        EnableDHCPv6 = true;
        RoutePriorityOffset = 300;
      };
      General = {
        UseDefaultInterface = false;
        IgnorePeerSignalStrength = true;
        EnableNetworkConfiguration = true;
        DisablePowerSave = true;
      };
    };
  };
  services.resolved.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;
  services.blueman.enable = false;
  hardware.pulseaudio.extraModules = with pkgs; [
    pulseaudio-modules-bt
  ];

  services.haveged.enable = false;
  # systemd.services.haveged.unitConfig.ConditionKernelVersion = lib.mkIf (config.services.haveged.enable) (lib.mkForce ">5.6");

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id.startsWith("net.connman.iwd") && subject.isInGroup("${config.users.users.i.group}")) {
        return polkit.Result.YES;
      }
    })
  '';

  networking.wireless.enable = false;
  networking.networkmanager.enable = false;

  networking.firewall = {
    enable = false;
    allowedTCPPorts = [ ];
    allowedTCPPortRanges = [ ];
    allowedUDPPorts = [ ];
    allowedUDPPortRanges = [
      {
        from = 32768;
        to = 61000;
      } # Chromecast client-to-control communication
    ];
  };
}
