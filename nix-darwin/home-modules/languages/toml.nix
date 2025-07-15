{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    toml.lsp.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables toml";
      default = true;
    };
  };

  config = lib.mkIf config.toml.lsp.enable {
    home = {
      packages = with pkgs; [
        taplo
      ];
    };
  };
}
