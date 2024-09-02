{ pkgs, lib, ... }:
let
  dataRootDir = "/media/Containers/docker";
in
{
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
  ];

  # docker
  virtualisation.docker = {
    enable = true;
    storageDriver = "overlay2";
    enableOnBoot = false;
    autoPrune = {
      enable = false;
    };
    daemon = {
      settings = {
        "data-root" = dataRootDir;
      };
    };
  };

  services.dockerRegistry.enable = false;
  environment.shellAliases = (
    let
      delimiter = "|";
      strFmtImgs = "{{.ID}} | {{.Size}}\t| {{.Repository}}:{{.Tag}}";
      containersActiveCmd = { cmd, args ? "", ... }: ''
        listID="$(docker ps ${args} | fzf -m | cut -d ' ' -f 1 | paste -s)";
        ! [ "$(echo $listID)" = "" ] && (${cmd}) 2> /dev/null > /dev/null &! ;
      '';
      containersInactiveCmd = { cmd, args ? "", ... }: ''
        listID="$(docker ps -a ${args} | fzf -m | cut -d ' ' -f 1 | paste -s)";
        ! [ "$(echo $listID)" = "" ] && (${cmd}) 2> /dev/null > /dev/null &! ;
      '';
      imgsCmd = { cmd, args ? "", ... }: ''
        listID="$(docker images ${args} | fzf -m | cut -d '|' -f 1 | paste -s)";
        ! [ "$(echo $listID)" = "" ] && (${cmd}) 2> /dev/null > /dev/null &! ; 
      '';
    in
    rec {
      doi = ''docker images'';
      dops = ''docker ps'';
      dopsa = ''${dops} -a'';
      dormiop = imgsCmd { cmd = "docker rmi -f $(echo $listID) && notify-send 'Success remove docker images'"; args = ''--format="${strFmtImgs}"''; };
      dormop = containersInactiveCmd { cmd = "docker rm $(echo $listID) && notify-send 'Success remove docker containers'"; };
      dormops = containersInactiveCmd { cmd = "docker rm $(echo $listID) && notify-send 'Success remove docker containers'"; args = "--size"; };
      doexecit = ''docker exec -it $(docker ps | fzf | cut -d " " -f 1)'';
      dostart = containersInactiveCmd { cmd = ''docker start $(echo $listID) && notify-send "Starting docker container done"''; };
      dostop = containersActiveCmd { cmd = ''docker stop $(echo $listID) && notify-send "Stoping docker container done"''; };
      doctx = ''ctx=$(docker context list | fzf | cut -d " " -f 1) && ! [ "$ctx" = "" ] && docker context use $ctx'';
    }
  );
}
