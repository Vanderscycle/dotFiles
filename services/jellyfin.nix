{ config, lib, ... }:
{
  options = {
    service.jellyfin.enable = lib.mkOption {
      type = lib.types.bool;
      description = "media service";
      default = false;
    };
  };

  config = lib.mkIf config.service.jellyfin.enable {
    services.jellyfin = {
      user = "admin";
      enable = true;
    };
  };
}
