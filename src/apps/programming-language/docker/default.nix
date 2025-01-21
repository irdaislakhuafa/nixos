{ pkgs, lib, ... }:
let
  isEnable = true;
in
lib.mkIf (isEnable) rec {
  environment.systemPackages = with pkgs; [
    docker-compose-language-service
    dockerfile-language-server-nodejs
  ];
}
