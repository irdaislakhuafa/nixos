{ pkgs, lib, ... }: {
  programs.neovim = {
    defaultEditor = true;
    enable = true;
    vimAlias = true;
    viAlias = true;
    configure = {
      customRC = builtins.readFile ./neovimrc;
    };
  };
}
