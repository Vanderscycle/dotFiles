{ config, lib, ... }:

let
  servarrServices = {
    radarr = {
      port = 7878;
    };
    sonarr = {
      port = 8989;
    };
    bazarr = {
      port = 6767;
    };
    lidarr = {
      port = 8686;
    };
    prowlarr = {
      port = 9696;
    };
    readarr = {
      port = 8787;
    };
  };
in
{
  options.service.servarr = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule {
        options.enable = lib.mkEnableOption "Enable this servarr service";
      }
    );
    default = { };
    description = "Options for individual servarr services";
  };

  config = lib.mkMerge (
    builtins.attrValues (
      lib.mapAttrs (
        name:
        { port }:
        lib.mkIf (config.service.servarr.${name}.enable or false) {
          services.${name} =
            {
              enable = true;
              openFirewall = false;
            }
            // lib.optionalAttrs (name == "bazarr") {
              listenPort = port;
            };
        }
      ) servarrServices
    )
  );
}
