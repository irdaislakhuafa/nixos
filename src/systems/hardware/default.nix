{ pkgs, ... }: {
  # enable hardware like wlan and etc
  hardware.enableRedistributableFirmware = true;
  hardware.pulseaudio.enable = false;
  environment.systemPackages = with pkgs; [
    pavucontrol
    alsa-utils
    easyeffects
  ];
  services.pipewire.enable = true;
  services.pipewire.audio.enable = true;
  services.pipewire.wireplumber.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.jack.enable = true;
  services.pipewire.pulse.enable = true;
}
