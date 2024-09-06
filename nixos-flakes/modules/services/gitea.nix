{ config, lib, pkgs, username, inputs, ... }:
#let
#domain = "test";
#in
#{
#  services.gitea = {
#    enable = true;
#    rootUrl = "https://git.${domain}/";
#    user = "git";
#    appName = "Gitea";
#    disableRegistration = true;
#    # inherit (config.networking) domain;
#    stateDir = "/srv/gitea";
#    repositoryRoot = "/home/${username}/repositories";
#    database = {
#      type = "sqlite3";
#      # inherit username;
#      path = "/home/${username}/gitea.db";
#    };
#    enableUnixSocket = true;
#    ssh = {
#      clonePort = lib.head config.services.openssh.ports;
#    };
#    lfs = {
#      enable = true;
#      contentDir = "/home/${username}/lfs";
#    };
#};
#}
{
    services.gitea.enable = true;
    services.gitea.httpAddress = "127.0.0.1";
    # services.gitea.domain = "gitea.mimas.internal.nobbz.dev";
    # services.gitea.settings.server.ROOT_URL = lib.mkForce "https://gitea.mimas.internal.nobbz.dev/";
    services.gitea.settings."git.timeout".DEFAULT = 3600; # 1 hour
    services.gitea.settings."git.timeout".MIGRATE = 3600; # 1 hour
    services.gitea.settings."git.timeout".MIRROR = 3600; # 1 hour
    services.gitea.settings."git.timeout".CLONE = 3600; # 1 hour
    services.gitea.settings."git.timeout".PULL = 3600; # 1 hour
    services.gitea.settings."git.timeout".GC = 3600; # 1 hour
    systemd.services.gitea.after = ["var-lib-gitea.mount"];
}
