{ pkgs, lib, ... }:
let
  isEnableAutoStart = false;
in
{
  # recommended to use VANILLA image and install GAPPS from https://github.com/irdaislakhuafa/waydroid_script.git (forked)
  # images stored in /var/lib/waydroid/images
  virtualisation.waydroid.enable = true;
  systemd.services.waydroid-container.wantedBy = lib.mkIf (!isEnableAutoStart) (lib.mkForce [ ]);
}
