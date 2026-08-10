{
  pkgs,
  config,
  lib,
  ...
}:
let
  isEnable = false;
in
lib.mkIf (isEnable) {
  services.fprintd.enable = true;
  services.fprintd.tod.enable = config.services.fprintd.enable;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;
  security.pam.services.login.fprintAuth = true;
}
