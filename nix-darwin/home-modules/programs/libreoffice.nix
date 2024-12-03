{ pkgs, ... }:
{
  home.packages = with pkgs; [
    libreoffice-qt
    hunspell
    hunspellDicts.en_CA
    hunspellDicts.en_US
  ];
}
