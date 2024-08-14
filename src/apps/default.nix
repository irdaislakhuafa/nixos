{ config, pkgs, lib, ... }: {
  imports = [
    ./cli/default.nix
    ./shell/default.nix
    ./container/default.nix
    ./web-browser/default.nix
    ./package-manager/default.nix
    ./window-manager/default.nix
    ./fonts/default.nix
    ./builder/default.nix
    ./display-manager/default.nix
    ./programming-language/default.nix
    ./image-viewer/default.nix
    ./video-player/default.nix
    ./rdp/default.nix
    ./dbms/default.nix
    ./system-monitor/default.nix
    ./android/default.nix
    ./api-client/default.nix
  ];
}
