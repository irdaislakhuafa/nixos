{ pkgs, ... }: {
  environment.systemPackages = with pkgs;[
    intel-gpu-tools
  ];
}
