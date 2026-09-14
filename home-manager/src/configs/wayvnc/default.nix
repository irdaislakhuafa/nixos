{
  pkgs,
  lib,
  config,
  ...
}:
let
  # Run command below to start the wayvnc
  # wayvnc --output=HEADLESS-2 0.0.0.0 5900 -v -L debug
  # the {HEADLESS-2} is the output that you want to stream
  isEnable = true;
  configDir = "${config.home.homeDirectory}/.config/wayvnc";
in
lib.mkIf (isEnable) {
  home.packages = [ pkgs.wayvnc ];
  home.file."${configDir}/config" = {
    enable = true;
    text = ''
      address=0.0.0.0
      port=5900
      enable_auth=true
      username=irdaislakhuafa
      password=00000000
      private_key_file=${configDir}/key.pem
      certificate_file=${configDir}/cert.pem
    '';
  };

  home.activation.wayvnc-key-and-cert = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.openssl}/bin/openssl req \
      -x509 \
      -nodes \
      -days 365 \
      -newkey rsa:2048 \
      -keyout ${configDir}/key.pem \
      -out ${configDir}/cert.pem \
      -subj "/CN=wayvnc"
  '';
}
