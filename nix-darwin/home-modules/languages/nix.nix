{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    nix.lsp.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables nix lsp";
      default = true;
    };
  };
  config = lib.mkIf config.nix.lsp.enable {
    home.packages = with pkgs; [
      nixfmt-rfc-style
      nixd # https://emacs-lsp.github.io/lsp-mode/page/lsp-nix-nixd/
      nixdoc
    ];
  };
}
