{ pkgs, ... }:
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
    "data-root" = "/media/Docker";
  };

  # docker rootless
  virtualisation.docker.rootless.enable = true;
  virtualisation.docker.rootless.daemon.settings = {
    "data-root" = "/media/Docker";
  };

  services.dockerRegistry.enable = true;
}
