{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    bash.lsp.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables bash lsp";
      default = true;
    };
  };
  config = lib.mkIf config.bash.lsp.enable {
    home.packages = with pkgs; [
      bash-language-server # npm i -g bash-language-server
      shellcheck
      shfmt
    ];
  };
}
