{ pkgs, ... }: {
  environment.systemPackages = with pkgs;[
    font-manager
  ];
  fonts.packages = with pkgs; [
    google-fonts
    fira-code
    fira-code-symbols
    fira-code-nerdfont
    jetbrains-mono
  ];
}
