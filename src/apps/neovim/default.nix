{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    neovim
  ];

  programs.neovim.defaultEditor = true;
  programs.neovim.enable = true;
  programs.neovim.vimAlias = true;
  programs.neovim.viAlias = true;
}
