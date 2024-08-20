{ pkgs, ... }: {
  environment.systemPackages = with pkgs;[
    font-manager
  ];
  fonts = {
    packages = with pkgs; [
      google-fonts
      fira-code
      fira-code-symbols
      fira-code-nerdfont
      jetbrains-mono
      font-awesome
      line-awesome
      font-awesome_5
      font-awesome_4
      fira-go
      scheherazade-new
    ];
    fontDir = {
      enable = true;
    };
    fontconfig = {
      enable = true;
    };
  };
}
