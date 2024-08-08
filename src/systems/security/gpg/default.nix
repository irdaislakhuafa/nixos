{pkgs,...}:{
    environment.systemPackages = with pkgs;[
        gnupg
    ];
    programs.gnupg.agent.enable = true;
    programs.gnupg.agent.enableBrowserSocket = true;
    programs.gnupg.agent.enableSSHSupport = true;
    programs.gnupg.agent.enableExtraSocket = true;
    programs.gnupg.dirmngr.enable = true;
}