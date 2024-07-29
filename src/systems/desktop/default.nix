{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    libnotify
    notify-osd
  ];
  xdg.portal.xdgOpenUsePortal = true;
  xdg.portal.enable = true;
}
