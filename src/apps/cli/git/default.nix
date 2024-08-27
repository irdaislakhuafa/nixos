{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
    gh
    gh-dash
    gh-cal
    gh-eco
    lazygit
    glab
  ];

  programs.git.enable = true;
  environment.shellAliases =
    let
      commandToBranch = { cmd, ... }: ''
        branch=$(git branch --all | fzf | cut -d ' ' -f 3);
        if ! [ "$branch" = "" ]; then
          ${cmd};
        fi;
      '';
    in
    rec{
      gst = "git status";
      gad = "git add";
      gps = "git push";
      grph = "git log --oneline --decorate --graph --cumulative --pretty";
      gout = "git checkout";
      gpl = "git pull";
      gouts = commandToBranch { cmd = "${gout} $branch"; };
      gbrd = commandToBranch { cmd = "git branch -D $branch"; };
      gmit = "git commit -m";
      gam = "git add --all && ${gmit}";
      gsdropc = "git stash && git stash drop";
      gsply = "git stash apply";
      gsdrop = "git stash drop";
      gdif = "git diff";
    };
}
