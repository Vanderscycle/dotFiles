{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    yaml.lsp.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables yaml lsp";
      default = false;
    };
  };

  config = lib.mkIf config.yaml.lsp.enable {
    home.packages = with pkgs; [
      #yaml
      nodePackages.yaml-language-server # npm i -g yaml-language-server
    ];
  };
}
