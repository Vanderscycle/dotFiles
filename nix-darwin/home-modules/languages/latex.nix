{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    languages.latex.lsp.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables latex";
      default = false;
    };
  };

  config = lib.mkIf config.languages.latex.lsp.enable {
    home.packages = with pkgs; [
      texliveFull # latex client
    ];
  };
}
