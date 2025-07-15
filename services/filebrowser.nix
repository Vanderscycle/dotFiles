{ config, lib, ... }:
{
  options = {
    service.filebrowser.enable = lib.mkOption {
      type = lib.types.bool;
      description = "filebrowser service";
      default = false;
    };
  };

  config = lib.mkIf config.service.filebrowser.enable {
    services.filebrowser = {
      enable = true;
      settings = {
        port = 8081;
      };
    };
  };
}
