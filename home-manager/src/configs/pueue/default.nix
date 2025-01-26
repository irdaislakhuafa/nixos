{ ... }:
{
  services.pueue = {
    enable = false;
    settings = {
      default_parallel_tasks = 10;
    };
  };
}
