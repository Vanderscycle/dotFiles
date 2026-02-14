{
  lib,
  config,
  ...
}:
{
  options = {
    program.awscli.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables aws cli v2";
      default = false;
    };

    program.awscli.settings = lib.mkOption {
      type = lib.types.attrs;
      description = "Aws cli config";
      default = { };
    };

    program.awscli.credentials = lib.mkOption {
      type = lib.types.attrs;
      description = "Aws cli credentials (please use sops)";
      default = { };
    };
    # program.linode.enable = lib.mkOption {
    #   type = lib.types.bool;
    #   description = "Enables linode cli";
    #   default = false;
    # };
  };

  config = lib.mkIf config.program.awscli.enable {
    programs = {
      awscli = {
        enable = true;
        settings = config.program.awscli.settings;
        credentials = config.program.awscli.credentials;
      };
    };
  };
}
