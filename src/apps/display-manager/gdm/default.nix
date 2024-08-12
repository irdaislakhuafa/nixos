{ pkgs, config, ... }: {
  environment.systemPackages = with pkgs;[
    gnome.gdm
  ];
  services.xserver.displayManager.gdm.enable = false;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.displayManager.gdm.debug = true;
  services.displayManager.defaultSession = "none+hyprland";
}
