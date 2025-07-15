{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    latex.lsp.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables latex";
      default = false;
    };
  };

  config = lib.mkIf config.latex.lsp.enable {
    home.packages = with pkgs; [
      texliveFull # latex client
    ];
  };
}
