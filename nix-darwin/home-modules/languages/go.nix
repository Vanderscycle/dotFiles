{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    languages.go.lsp.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables go lsp";
      default = false;
    };
  };

  config = lib.mkIf config.languages.go.lsp.enable {
    programs = {
      go = {
        enable = true;
      };
    };
    home = {
      packages = with pkgs; [
        gopls
      ];
    };
  };
}
