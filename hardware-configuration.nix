# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usb_storage"
    "sd_mod"
    "rtsx_usb_sdmmc"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems =
    let
      mediaDir = "/media";
    in
    {
      "/" = {
        device = "/dev/nvme0n1p2";
        fsType = "btrfs";
        options = [ "compress=zstd" "noatime" "discard" "ssd" ];
      };

      "/boot" = {
        device = "/dev/disk/by-uuid/19B6-FFE7";
        fsType = "vfat";
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
      };

      "/tmp" = {
        device = "tmpfs";
        fsType = "tmpfs";
        options = [
          "defaults"
          "size=${toString (1024 * 4)}M"
        ];
      };

      # my drive [ssd]
      "${mediaDir}/My_Drive" = {
        device = "/dev/disk/by-uuid/d979df62-b424-446e-bf13-7996ab39c471";
        fsType = "f2fs";
        noCheck = true;
      };

      # docker
      "${mediaDir}/Containers" = {
        device = "/dev/disk/by-uuid/f0268e95-ca28-4452-9202-71f2562230c5";
        fsType = "ext4";
        noCheck = true;
      };
      # libraries
      "${mediaDir}/Libraries" = {
        device = "/dev/disk/by-uuid/0c3fce54-c4a9-4fbe-b7c8-d967cda5546d";
        fsType = "ext4";
        noCheck = true;
      };
      # projects
      "${mediaDir}/Projects" = {
        device = "/dev/disk/by-uuid/c3edf5d8-9a2e-4070-a241-5a50f6297b25";
        fsType = "ext4";
        noCheck = true;
      };
      # my files
      "${mediaDir}/MyFiles" = {
        device = "/dev/disk/by-uuid/5d45ad9d-2be3-49cd-a85a-b01048310ed1";
        fsType = "ext4";
        noCheck = true;
      };
      # games
      "${mediaDir}/Games" = {
        device = "/dev/disk/by-uuid/ea80b12b-6bfd-49fd-ad88-fecc738d5fe7";
        fsType = "btrfs";
        options = [ "compress=zstd" ];
        noCheck = true;
      };
      # virt manager
      "${mediaDir}/VirtManager" = {
        device = "/dev/disk/by-uuid/b3e1fee7-cb4f-47ec-a03c-a89753f626f2";
        fsType = "ext4";
        noCheck = true;
      };
      # temporary
      "${mediaDir}/Temporary" = {
        device = "/dev/disk/by-uuid/6331c7d9-3269-486e-bc13-ab7c7e170fe8";
        fsType = "ext4";
        noCheck = true;
      };
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
