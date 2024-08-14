{ pkgs, ... }:
let
  dataRootDir = "/media/Docker";
in
{
  environment.systemPackages = with pkgs; [
    docker
    docker-slim
    docker-compose
    oxker
  ];

  # docker
  virtualisation.docker = {
    enable = false;
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
      shell = "sh";
    in
    rec {
      doi = ''docker images'';
      dops = ''docker ps'';
      dopsa = ''${dops} -a'';
      dormiop = ''
        listID="$(docker images --format="${strFmtImgs}" | fzf -m | cut -d '|' -f 1)";
        if ! [ $listID = "" ]; then
          ${shell} -c "docker rmi $(echo $listID | paste -s) && notify-send 'Success remove docker images'" & ;
        fi;
      '';
      dormop = ''
        listID="$(docker ps -a | fzf -m | cut -d ' ' -f 1)"; 
        if ! [ $listID = "" ]; then
          ${shell} -c "docker rm $(echo $listID | paste -s) && notify-send 'Success remove docker containers'" & ;
        fi;
      '';
      dormops = ''
        listID="$(docker ps -a --size | fzf -m | cut -d ' ' -f 1)"; 
        if ! [ $listID = "" ]; then
          ${shell} -c "docker rm $(echo $listID | paste -s) && notify-send 'Success remove docker containers'" & ;
        fi;
      '';
      doexecit = ''docker exec -it $(docker ps | fzf | cut -d " " -f 1)'';
      dostart = ''
        listID="$(docker ps -a | fzf -m | cut -d ' ' -f 1)"; 
        if ! [ $listID = "" ]; then
          ${shell} -c "docker start $(echo $listID | paste -s) && notify-send 'Starting docker container done'" & ;
        fi;
      '';
      dostop = ''
        listID="$(docker ps | fzf -m | cut -d ' ' -f 1)"; 
        if ! [ $listID = "" ]; then
          ${shell} -c "docker stop $(echo $listID | paste -s) && notify-send 'Stoping docker container done'" & ;
        fi;
      '';
    }
  );
}
