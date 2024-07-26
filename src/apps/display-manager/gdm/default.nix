{ pkgs, config, ... }: {
  environment.systemPackages = with pkgs;[
    gnome.gdm
  ];
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.displayManager.gdm.debug = true;
  services.xserver.displayManager.defaultSession = "none+hyprland";
}
