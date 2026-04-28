{
  den,
  __findFile,
  ...
}:
{
  den.aspects.khan = {
    includes = [
      <den/primary-user>
      (den.provides.user-shell "fish")
      <steppe/theming>
      <steppe/program/browser>
      <steppe/program/zathura>
      <steppe/program/jujutsu>
      <steppe/window-manager/hyprland> # WARN: cannot be tied to the hosts unlike xfce
      <steppe/shell>
      <steppe/gui>
      <steppe/program/git>
      <steppe/program/spotify>
      <steppe/program/nh>
      <steppe/program/keychain>
      # <steppe/program/yubico>
      # languages
      <steppe/languages/typescript>
      <steppe/languages/latex>
      <steppe/languages/template>
      <steppe/languages/bash>
      # editors
      <steppe/program/emacs>
      <steppe/program/vim>
    ];
    nixos = {
      users.users."khan" = {
        initialPassword = "password123";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILUce912jMG3OgdDNUBfzhqk/jOsx9ZGLKDMYvyDHuYk temujin@vandersleyen.xyz"
          # TODO: rotate
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMCpHZBybBTCsCyW6/Q4OZ07SvUpRUvclc10u25j0B+Q hvandersleyen@gmail.com"
        ];
        extraGroups = [ "docker" ];
      };
      security.sudo.extraConfig = ''
        Defaults        timestamp_timeout=3600
      '';
      services = {
        displayManager = {
          autoLogin = {
            enable = true;
            user = "khan";
          };
        };
      };
    };
    homeManager =
      { config, pkgs, ... }:
      {
        sops.secrets."aws/access-key" = { };
        sops.secrets."aws/secret-access-key" = { };
        home = {
          packages = with pkgs; [ sysz ];
        };
        services = {
          ssh-agent = {
            enable = false; # INFO: false bcause we want to use keychain
          };
        };
        programs = {
          awscli = {
            enable = true;

            settings = {
              "AdministratorAccess-975050082671" = {
                region = "us-east-1";
                output = "json";
              };
              "default" = {
                region = "us-east-1";
                output = "json";
              };
            };

            credentials = {
              "root" = {
                aws_access_key_id = config.sops.secrets."aws/access-key".path;
                aws_secret_access_key = config.sops.secrets."aws/secret-access-key".path;
              };
            };
          };
          ssh = {
            enable = true;
            enableDefaultConfig = false;
            matchBlocks = {
              # gitea = {
              #   hostname = "gitea.homecloud.lan";
              #   user = "git";
              #   identityFile = "/home/${meta.username}/.ssh/gitea";
              # };
              medialab = {
                hostname = "192.168.1.196";
                user = "medialab";
              };
              monolith = {
                hostname = "192.168.2.228";
                user = "monolith";
              };
              opencode = {
                hostname = "192.168.2.153";
                user = "opencode";
              };
              nas = {
                hostname = "192.168.2.227";
                user = "nas";
              };
              # steamdeck = {
              #   hostname = "192.168.1.146";
              #   user = "deck";
              # };
            };
          };
        };
      };
  };
}
