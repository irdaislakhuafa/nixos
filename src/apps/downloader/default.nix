{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wget2
    aria2
  ];
  environment.shellAliases = {
    wget = "wget2 --tls-resume --continue --compression=auto";
    aria = "aria2c -x 16 -s 16 -k 1M --min-split-size=1M --max-connection-per-server=16 --optimize-concurrent-downloads=true";
  };
}
