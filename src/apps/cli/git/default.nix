{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
    gh
    gh-dash
    gh-cal
    gh-eco
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
    {
      gst = "git status";
      gad = "git add";
      gps = "git push";
      grph = "";
      gpl = "git pull";
      gouts = commandToBranch { cmd = "git checkout $branch"; };
      gbrd = commandToBranch { cmd = "git branch -D $branch"; };
    };
}
