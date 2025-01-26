{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    process-compose
  ];
  environment.shellAliases = {
    procom = "process-compose -t=false";
  };
}
