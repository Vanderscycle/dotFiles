{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    languages.toml.lsp.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables toml";
      default = true;
    };
  };

  config = lib.mkIf config.languages.toml.lsp.enable {
    home = {
      packages = with pkgs; [
        taplo
      ];
    };
  };
}
