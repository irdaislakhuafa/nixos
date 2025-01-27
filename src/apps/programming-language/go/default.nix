{ config, pkgs, lib, ... }:
let
  isEnable = false;
in
lib.mkIf (isEnable) rec {
  environment.systemPackages = with  pkgs; [
    go
  ];
  environment.variables = {
    GOPATH = "/home/${config.users.users.i.name}/go";
    PATH = "$PATH:$GOPATH/bin";
    GOME = "github.com/irdaislakhuafa";
  };
  environment.shellAliases = {
    gonit = "go mod init $GOME/$(basename $(pwd))";
    grun = "go run";
  };
}
