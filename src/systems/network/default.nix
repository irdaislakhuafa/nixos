{
  pkgs,
  config,
  inputs,
  ...
}:
{
  imports = (import ../../../importer.nix { dir = builtins.toPath ./.; });

  environment.systemPackages = with pkgs; [
    iwd
    # openvpn
    wirelesstools
    # bluetuith
    # impala
    inputs.iwmenu.packages.${pkgs.system}.default
  ];

  networking.hostName = "developer";
  networking.useNetworkd = false;
  networking.useDHCP = false;

  networking.wireless.iwd = {
    package = pkgs.iwd;
    enable = true;
    settings = {
      Network = rec {
        EnableIPv6 = false;
        EnableDHCPv6 = EnableIPv6;
        RoutePriorityOffset = 300;
        NameResolvingService = "systemd";
      };
      General = {
        UseDefaultInterface = false;
        IgnorePeerSignalStrength = false;
        EnableNetworkConfiguration = true;
        DisablePowerSave = true;
        AutoConnect = true;
      };
    };
  };
  services.resolved.enable = true;
  services.pulseaudio.extraModules = with pkgs; [
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
      # Chromecast client-to-control communication
      {
        from = 32768;
        to = 61000;
      }
    ];
  };
}
