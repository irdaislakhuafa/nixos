{ pkgs, lib, ... }: {
  programs.neovim = {
    defaultEditor = true;
    enable = true;
    vimAlias = true;
    viAlias = true;
    plugins = with pkgs.vimPlugins; [ ];
  };
}
