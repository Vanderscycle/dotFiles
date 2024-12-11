{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    json.lsp.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables json lsp";
      default = false;
    };
  };

  config = lib.mkIf config.json.lsp.enable {
    home.packages = with pkgs; [
      # nodePackages.yaml-language-server #npm i -g yaml-language-server
      # npm i -g vscode-langservers-extracted
    ];
  };
}
