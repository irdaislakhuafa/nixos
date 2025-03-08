{ pkgs, lib, ... }:
let
  aliases = (
    let
      commandToBranch =
        { cmd, ... }:
        ''
          branch=$(git branch --all | fzf | cut -d ' ' -f 3);
          if ! [ "$branch" = "" ]; then
            ${cmd};
          fi;
        '';
    in
    lib.mapAttrsToList (name: value: (pkgs.writeShellScriptBin name value)) (rec {
      gst = ''git status $@'';
      gad = ''git add $@'';
      gps = ''git push $@'';
      grph = ''git log --oneline --decorate --graph --cumulative --pretty $@'';
      gout = ''git checkout $@'';
      gpl = ''git pull $@'';
      gouts = commandToBranch { cmd = ''${gout} $branch''; };
      gbrd = commandToBranch {
        cmd = ''for b in $(echo $branch | ${pkgs.coreutils-full}/bin/paste -s); do git branch -D $b; done'';
      };
      gmit = ''git commit $@'';
      gam = ''git add --all && ${gmit}'';
      gsdropc = ''git stash && git stash drop'';
      gsply = ''git stash apply $@'';
      gsdrop = ''git stash drop $@'';
      gdif = ''git diff $@'';
      gfa = ''git fetch --all --prune-tags --prune --jobs=$(cat /sys/devices/cpu/type) $@'';
      gbr = ''git branch $@'';
    })
  );
in
{
  programs.git.enable = true;
  environment.systemPackages = [
    pkgs.git
    pkgs.gh
    pkgs.glab
  ] ++ aliases;
}
