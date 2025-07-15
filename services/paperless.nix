{ config, ... }:
{
  systemd.services.paperless = {
    wants = [ "mnt-paperless.mount" ];
    after = [ "mnt-paperless.mount" ];
    serviceConfig = {
      ProtectSystem = "no";
      ProtectHome = false;
      PrivateTmp = false;
      PrivateDevices = false;
      ReadOnlyPaths = [ ];
      ReadWritePaths = [ "/mnt/paperless" ];
    };
  };

  users.users.paperless = {
    isNormalUser = false;
    extraGroups = [
      "smbaccess"
    ];
  };
  environment.etc."paperless-admin-pass".text =
    builtins.readFile
      config.sops.secrets."paperless/admin/password".path;

  services.paperless = {
    passwordFile = "/etc/paperless-admin-pass";
    enable = true;
    port = 28981;
    address = "127.0.0.1";
    settings = {
      # PAPERLESS_CONSUMPTION_DIR = "/mnt/paperless/consume";
      # PAPERLESS_DATA_DIR = "/mnt/paperless/data";
      # PAPERLESS_MEDIA_ROOT = "/mnt/paperless/media";
      # PAPERLESS_STATICDIR = "/mnt/paperless/static";
      # https://docs.paperless-ngx.com/configuration/
      # PAPERLESS_FORCE_SCRIPT_NAME = "/paperless";
      # PAPERLESS_STATIC_URL = "/paperless/";

      # PAPERLESS_ADMIN_USER = builtins.readFile config.sops.secrets."paperless/admin/username".path;
      # PAPERLESS_ADMIN_MAIL = builtins.readFile config.sops.secrets."paperless/admin/email".path;
      # PAPERLESS_ADMIN_PASSWORD = builtins.readFile config.sops.secrets."paperless/admin/password".path;
    };
  };
}
