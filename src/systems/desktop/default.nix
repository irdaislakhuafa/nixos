{ pkgs, lib, ... }: {
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
    enable = lib.mkForce false;
    addedAssociations = {
      "application/pdf" = [ "" ];
      "video/*" = [ "mpv.desktop" ];
      "image/*" = [ "imv.desktop" ];
    };
  };
  xdg.sounds.enable = true;
}
