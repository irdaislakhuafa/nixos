{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    docker
    docker-slim
    docker-compose
    oxker
  ];

  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "overlay2";
  virtualisation.docker.enableOnBoot = false;
  virtualisation.docker.rootless.enable = true;
  virtualisation.docker.autoPrune.enable = false;

  services.dockerRegistry.enable = true;
}
