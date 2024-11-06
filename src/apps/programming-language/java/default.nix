{ pkgs, lib,...}:
let
  isEnable = true;
in lib.mkIf (isEnable) {
  environment.systemPackages = with pkgs; [
    jdt-language-server
    spring-boot-cli
  ];
}
