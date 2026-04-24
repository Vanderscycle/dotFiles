{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    languages.yaml.lsp.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables yaml lsp";
      default = false;
    };
  };

  config = lib.mkIf config.languages.yaml.lsp.enable {
    home.packages = with pkgs; [
      yaml-language-server
    ];
  };
}
