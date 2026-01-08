{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    languages.python.lsp.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables python lsp";
      default = true;
    };
  };

  config = lib.mkIf config.languages.python.lsp.enable {
    home = {
      packages = with pkgs; [
        # python311
        poetry
        pyright
        (python313.withPackages (
          ps: with ps; [
            pip
            python-lsp-server
            isort
            black
            flake8
          ]
        ))
      ];
    };
  };
}
