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
        godef
        gopls # LSP server
        gotools # Includes goimports, guru, etc.
        gomodifytags # For struct tag manipulation
        gotests # Test generation
        gore # Go REPL (if you actually use it)
        golangci-lint # Linting
        delve # Debugger
      ];
    };
  };
}
