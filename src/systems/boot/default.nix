{ config, pkgs, ... }:
{
  # Use the systemd-boot EFI boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  boot.kernelModules = [ "kvm-linux" ];

  # for boot operation
  environment.shellAliases = rec{
    zzz = "systemctl suspend";
    boot = "systemctl reboot";
    sboot = "systemctl soft-reboot";
    off = "systemctl poweroff";
    offf = "${off} -f";
    bootfw = "${boot} --firmware-setup";
  };

  # systctl config for minimalist system with lower memory cosumtion and power usage
  boot.kernel.sysctl = {
    "vm.swappiness" = 60;

    # Reduce dirty page writeback frequency to save power
    "vm.dirty_writeback_centisecs" = 3000;

    # Disable TCP timestamps (saves CPU cycles)
    "net.ipv4.tcp_timestamps" = 0;

    # Minimize the overcommit ratio for better memory management
    "vm.overcommit_ratio" = 50;
    "vm.overcommit_memory" = 1; # 0/1/2

    # Decrease VFS cache pressure to reduce I/O
    "vm.vfs_cache_pressure" = 50;

    # Increase TCP buffer sizes for better network latency
    "net.core.rmem_max" = 2097152;
    "net.core.wmem_max" = 2097152;
    "net.ipv4.tcp_rmem" = "4096 1048576 2097152";
    "net.ipv4.tcp_wmem" = "4096 1048576 2097152";

    # Reduce ARP table timeouts to reduce background processing
    "net.ipv4.neigh.default.gc_stale_time" = 60;

    # Power-saving tweaks for wakeup reduction
    "kernel.nmi_watchdog" = 0;
    "kernel.sched_autogroup_enabled" = 0;

    # Decrease the number of dirty pages in RAM before writing them to disk
    "vm.dirty_ratio" = 10;
    "vm.dirty_background_ratio" = 5;

    # Reduce unneeded kernel logs (less disk writes)
    "kernel.printk" = "3 3 3 3";

    # For battery saving on laptop (enable it if you are running on battery)
    "vm.laptop_mode" = 1;

    # Reduce default readahead to save memory (useful for SSDs)
    "vm.page-cluster" = 0;
  };
}
