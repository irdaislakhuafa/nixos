{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wget2
  ];
  environment.shellAliases = {
    wget = "wget2 --tls-resume --continue --compression=auto";
  };
}
