{ ... }: {
  # enable hardware like wlan and etc
  hardware.enableRedistributableFirmware = true;
  hardware.opengl.enable = true;
  sound.enable = true;
  hardware.pulseaudio.enable = true;
}
