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
    ];
  };
  services = {
    emacs = {
      enable = true;
    };
  };
}
