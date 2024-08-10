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
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "overlay2";
  virtualisation.docker.enableOnBoot = false;
  virtualisation.docker.autoPrune.enable = false;
  virtualisation.docker.daemon.settings = {
    "data-root" = dataRootDir;
  };

  # docker rootless
  virtualisation.docker.rootless.enable = true;
  virtualisation.docker.rootless.daemon.settings = {
    "data-root" = dataRootDir;
  };

  services.dockerRegistry.enable = true;
  environment.shellAliases = (
    let
      delimiter = "|";
      strFmtImgs = "{{.ID}} | {{.Size}}\t| {{.Repository}}:{{.Tag}}";
      shell = "sh";
    in
    {
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
