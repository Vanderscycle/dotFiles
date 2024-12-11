{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    spacemacs.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables the cooler vim";
      default = true;
    };
  };

  config = lib.mkIf config.spacemacs.enable {
    home = {
      sessionVariables = {
        EDITOR = "emacs";
        SUDO_EDITOR = "emacs";
      };
      packages = with pkgs; [
        emacs-all-the-icons-fonts
        libtool
        sqlite
        cmake
        gcc
        libgccjit
        editorconfig-core-c
      ];
    };

    programs = {
      emacs = {
        enable = true;
      };
    };
    services = {
      emacs = {
        enable = true;
        package = pkgs.emacs;
      };
    };
  };
}
