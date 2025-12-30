{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    program.spacemacs.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables the cooler vim";
      default = true;
    };
  };

  # common issue on MacOs when getting ="Creating pipe" "too many open files"=
  # https://gist.github.com/tombigel/d503800a282fcadbee14b537735d202c
  config = lib.mkIf config.program.spacemacs.enable {
    systemd.user.services.emacs.Service = {
      Restart = lib.mkForce "always";
      RestartSec = "3";
    };
    home = {
      sessionVariables = {
        EDITOR = "emacs";
        SUDO_EDITOR = "emacs";
      };
      packages = with pkgs; [
        emacs-all-the-icons-fonts
        glibtool
        libtool
        sqlite
        cmake
        gcc
        libgccjit
        editorconfig-core-c
        ispell
        devcontainer
      ];
    };

    programs = {
      emacs = {
        enable = true;
        package = pkgs.emacs;
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
