{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ xrdp ];
  services.xrdp.audio.enable = true;
}
