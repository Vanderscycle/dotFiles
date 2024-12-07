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
  services = {
    emacs = {
      enable = true;
    };
  };
}
