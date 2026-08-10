{ lib, pkgs, ... }:
let
  isEnable = true;
in
lib.mkIf (isEnable) {
  environment.systemPackages = [
    pkgs.virt-manager
  ];
  virtualisation.libvirtd = {
    enable = true;
    nss = {
      enable = true;
      enableGuest = true;
    };
    qemu = {
      swtpm.enable = true;
      ovmf.enable = true;
    };
  };
  virtualisation.spiceUSBRedirection.enable = true;
}
