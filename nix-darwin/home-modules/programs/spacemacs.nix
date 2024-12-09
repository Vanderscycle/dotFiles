{ pkgs, ... }:
{
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
}
