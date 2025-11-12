{pkgs, ...}:{
  home.packages = with pkgs;[
    lunarvim
    lazygit
  ];
  home.file.".config/lvim/config.lua".source = builtins.readFile ./config.lua;
}
