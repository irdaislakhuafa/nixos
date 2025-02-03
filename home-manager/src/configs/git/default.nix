{ pkgs, ... }:
{
  home.packages = [
    # pkgs.gitui
  ];

  programs.git = {
    enable = true;
    userName = "Irda Islakhu Afa";
    userEmail = "irdhaislakhuafa@gmail.com";
  };
}
