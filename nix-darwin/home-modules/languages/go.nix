{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    go.lsp.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables go lsp";
      default = false;
    };
  };

  config = lib.mkIf config.go.lsp.enable {
    programs = {
      go = {
        enable = true;
      };
    };
    home = {
      packages = with pkgs; [
      ];
    };
  };
}
