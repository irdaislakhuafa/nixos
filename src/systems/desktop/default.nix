{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    libnotify
    notify-osd
    rtkit
    xdg-utils
  ];
  xdg.portal.xdgOpenUsePortal = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-hyprland
  ];
  security.rtkit.enable = true;

  xdg.mime = {
    enable = lib.mkForce true;
    addedAssociations = {
      "application/pdf" = [ "org.qutebrowser.qutebrowser.desktop" ];
      "video/*" = [ "mpv.desktop" ];
      "image/*" = [ "imv.desktop" ];
      "text/html" = [ "org.qutebrowser.qutebrowser.desktop" ];
      "x-scheme-handler/http" = [ "org.qutebrowser.qutebrowser.desktop" ];
      "x-scheme-handler/https" = [ "org.qutebrowser.qutebrowser.desktop" ];
      "x-scheme-handler/about" = [ "org.qutebrowser.qutebrowser.desktop" ];
      "x-scheme-handler/unknown" = [ "org.qutebrowser.qutebrowser.desktop" ];
    };
  };
  xdg.sounds.enable = true;
}
