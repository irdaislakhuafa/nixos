{ pkgs, lib, ... }: {
  programs.neovim = {
    defaultEditor = false;
    enable = false;
    vimAlias = true;
    viAlias = true;
    configure = {
      customRC = builtins.readFile ./neovimrc;
    };
  };
}
