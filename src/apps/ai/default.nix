{ pkgs, ... }: {
  environment.systemPackages = with pkgs;[
    aichat
    # gptcommit
  ];
}
