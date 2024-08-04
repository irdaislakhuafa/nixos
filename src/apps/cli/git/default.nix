{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
    gh
    gh-dash
    gh-cal
    gh-eco
  ];

  programs.git.enable = true;
  environment.shellAliases = {
    gst = "git status";
    gad = "git add";
  };
}
