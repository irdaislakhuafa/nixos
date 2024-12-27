{ pkgs, ... }: {
  environment.systemPackages = with pkgs;[
    font-manager
  ];
  fonts = {
    packages = with pkgs; [
      google-fonts
      fira-code
      fira-code-symbols
      nerd-fonts.fira-code
      nerd-fonts.hack
      nerd-fonts.noto
      nerd-fonts.fira-mono
      noto-fonts
      material-icons
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
