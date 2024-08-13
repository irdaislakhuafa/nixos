{ pkgs, ... }: {
  home.packages = with pkgs;[
    taskwarrior
  ];
  programs.taskwarrior = {
    enable = true;
    colorTheme = "dark-blue-256";
    config = {
      confirmation = false;
    };
  };
}
