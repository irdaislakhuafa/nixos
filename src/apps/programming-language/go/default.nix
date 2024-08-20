{ config, pkgs, ... }: rec {
  environment.systemPackages = with  pkgs; [
    go
  ];
  environment.variables = {
    GOPATH = "/home/${config.users.users.i.name}/go";
    PATH = "$PATH:$GOPATH/bin/";
    GOME = "github.com/irdaislakhuafa";
  };
}
