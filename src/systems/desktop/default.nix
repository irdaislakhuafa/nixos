{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    libnotify
    notify-osd
    rtkit
    xdg-utils
  ];
  xdg.portal.xdgOpenUsePortal = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    pkgs.xdg-desktop-portal-hyprland
  ];
  security.rtkit.enable = true;
}
