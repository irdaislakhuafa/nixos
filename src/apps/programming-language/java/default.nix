{ pkgs, lib,...}:
let
  isEnable = false;
in lib.mkIf (isEnable) {
  environment.systemPackages = with pkgs; [
    jdt-language-server
    spring-boot-cli
  ];
}
