{ pkgs, lib, ... }:
let
  dataRootDir = "/media/Containers/docker";
  # aliases =
  #   let
  #     delimiter = "|";
  #     strFmtImgs = "{{.ID}} ${delimiter} {{.Size}}\t${delimiter} {{.Repository}}:{{.Tag}}";
  #     containersActiveCmd =
  #       {
  #         cmd,
  #         args ? "",
  #         ...
  #       }:
  #       ''
  #         listID="$(docker ps ${args} | fzf -m | cut -d ' ' -f 1 | paste -s)";
  #         ! [ "$(echo $listID)" = "" ] && (${cmd}) 2> /dev/null > /dev/null &! ;
  #       '';
  #     containersInactiveCmd =
  #       {
  #         cmd,
  #         args ? "",
  #         ...
  #       }:
  #       ''
  #         listID="$(docker ps -a ${args} | fzf -m | cut -d ' ' -f 1 | paste -s)";
  #         ! [ "$(echo $listID)" = "" ] && (${cmd}) 2> /dev/null > /dev/null &! ;
  #       '';
  #     imgsCmd =
  #       {
  #         cmd,
  #         args ? "",
  #         ...
  #       }:
  #       ''
  #         listID="$(docker images ${args} | fzf -m | cut -d '|' -f 1 | paste -s)";
  #         ! [ "$(echo $listID)" = "" ] && (${cmd}) 2> /dev/null > /dev/null &! ;
  #       '';
  #   in
  #   lib.mapAttrsToList (name: value: (pkgs.writeShellScriptBin name value)) ({
  #     "doi" = ''
  #       docker images $@
  #     '';
  #     "dops" = ''
  #       docker ps $@
  #     '';
  #     "dopsa" = ''
  #       dops -a $@
  #     '';
  #     "dormiop" = ''
  #       ${imgsCmd {
  #         cmd = "docker rmi -f $(echo $listID) && notify-send 'Success remove docker images'";
  #         args = ''--format="${strFmtImgs}"'';
  #       }}
  #     '';
  #     "doexecit" = ''
  #       ${imgsCmd {
  #         cmd = "docker rmi -f $(echo $listID) && notify-send 'Success remove docker images'";
  #         args = ''--format="${strFmtImgs}"'';
  #       }}
  #     '';
  #     "dormop" = ''
  #       ${containersInactiveCmd {
  #         cmd = "docker rm $(echo $listID) && notify-send 'Success remove docker containers'";
  #       }}
  #     '';
  #     "dormops" = ''
  #       ${containersInactiveCmd {
  #         cmd = "docker rm $(echo $listID) && notify-send 'Success remove docker containers'";
  #         args = "--size";
  #       }}
  #     '';
  #     "dostart" = ''
  #       ${containersInactiveCmd {
  #         cmd = ''docker start $(echo $listID) && notify-send "Starting docker container done"'';
  #       }}
  #     '';
  #     "dostop" = ''
  #       ${containersActiveCmd {
  #         cmd = ''docker stop $(echo $listID) && notify-send "Stoping docker container done"'';
  #       }}
  #     '';
  #     "doctx" = ''
  #       ${containersActiveCmd {
  #         cmd = ''docker stop $(echo $listID) && notify-send "Stoping docker container done"'';
  #       }}
  #     '';
  #     "docom" = ''
  #       docker compose $@
  #     '';
  #     "dobx" = ''
  #       docker buildx $@
  #     '';
  #     "disbx" = ''
  #       distrobox $@
  #     '';
  #   });
  # [
  #   (pkgs.writeShellScriptBin "doi" ''
  #     docker images $@
  #   '')
  #   (pkgs.writeShellScriptBin "dops" ''
  #     docker ps $@
  #   '')
  #   (pkgs.writeShellScriptBin "dopsa" ''
  #     dops -a $@
  #   '')
  #   (pkgs.writeShellScriptBin "dormiop" ''

in
#   '')
#   (pkgs.writeShellScriptBin "doexecit" ''
#     ${imgsCmd {
#       cmd = "docker rmi -f $(echo $listID) && notify-send 'Success remove docker images'";
#       args = ''--format="${strFmtImgs}"'';
#     }}
#   '')
#   (pkgs.writeShellScriptBin "dormop" ''
#     ${containersInactiveCmd {
#       cmd = "docker rm $(echo $listID) && notify-send 'Success remove docker containers'";
#     }}
#   '')
#   (pkgs.writeShellScriptBin "dormops" ''
#     ${containersInactiveCmd {
#       cmd = "docker rm $(echo $listID) && notify-send 'Success remove docker containers'";
#       args = "--size";
#     }}
#   '')
#   (pkgs.writeShellScriptBin "dostart" ''
#     ${containersInactiveCmd {
#       cmd = ''docker start $(echo $listID) && notify-send "Starting docker container done"'';
#     }}
#   '')
#   (pkgs.writeShellScriptBin "dostop" ''
#     ${containersActiveCmd {
#       cmd = ''docker stop $(echo $listID) && notify-send "Stoping docker container done"'';
#     }}
#   '')
#   (pkgs.writeShellScriptBin "doctx" ''
#     ${containersActiveCmd {
#       cmd = ''docker stop $(echo $listID) && notify-send "Stoping docker container done"'';
#     }}
#   '')
#   (pkgs.writeShellScriptBin "docom" ''
#     docker compose $@
#   '')
#   (pkgs.writeShellScriptBin "dobx" ''
#     docker buildx $@
#   '')
#   (pkgs.writeShellScriptBin "disbx" ''
#     distrobox $@
#   '')
# ];
{
  environment.systemPackages = [
    pkgs.docker
    pkgs.docker-compose
    pkgs.distrobox
    pkgs.virt-manager
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
        "dns" = [ ];
        "group" = "docker";
        "hosts" = [ "fd://" ];
        "live-restore" = true;
        "log-driver" = "journald";
        # "default-address-pools" = [
        #   {
        #     # "base" = "192.168.200.0/24";
        #     "base" = "172.30.0.0/16";
        #     "size" = 24;
        #   }
        # ];
        "bip" = "100.100.0.1/16";
      };
    };
  };

  virtualisation.libvirtd = {
    enable = true;
    nss = {
      enable = true;
      enableGuest = true;
    };
    qemu = {
      # package = pkgs.qemu_kvm;
      swtpm.enable = true;
      ovmf.enable = true;
    };
  };
  virtualisation.spiceUSBRedirection.enable = true;

  services.dockerRegistry.enable = false;
}
