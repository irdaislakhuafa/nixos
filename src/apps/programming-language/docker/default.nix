{ pkgs, lib, ... }:
let
  isEnable = false;
in
lib.mkIf (isEnable) rec {
  environment.systemPackages = with pkgs; [
    docker-compose-language-service
    dockerfile-language-server-nodejs
  ];
}
