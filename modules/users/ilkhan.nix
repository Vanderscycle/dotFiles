{
  den,
  __findFile,
  ...
}:
{
  den.aspects.ilkhan = {
    includes = [
      # <den/primary-user>
      (den.provides.user-shell "fish")
      <steppe/theming>
      <steppe/program/browser>
      <steppe/shell>
      <steppe/program/kitty>
      # languages
      <steppe/languages/bash>
      # editors
      <steppe/program/vim>
    ];
    nixos =
      { config, ... }:
      {
        sops.secrets."home-server/wifi/password" = { };
        sops.secrets."home-server/wifi/name" = { };
        users.users."ilkhan" = {
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILUce912jMG3OgdDNUBfzhqk/jOsx9ZGLKDMYvyDHuYk temujin@vandersleyen.xyz"
          ];
          extraGroups = [ "docker" ];
        };
        security.sudo.extraConfig = ''
          Defaults        timestamp_timeout=3600
        '';

        networking = {
          networkmanager.enable = false;
          wireless = {
            enable = true;
            networks = {
              "homelab_wifi" = {
                psk = config.sops.secrets."home-server/wifi/password".path;
              };
            };
          };
        };
        services = {
          displayManager = {
            autoLogin = {
              enable = true;
              user = "ilkhan";
            };
          };
        };
      };
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [ vlc ];
        programs.ssh = {
          enable = true;
        };
        services = {
          ssh-agent = {
            enable = true; # INFO: false bcause we want to use keychain
          };
        };
      };
  };
}
