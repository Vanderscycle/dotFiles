{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      nerdfonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      roboto
    ];
    fontconfig.defaultFonts = {
      serif = [ "Roboto Serif" "Noto Color Emoji" ];
      sansSerif = [ "Roboto" "Noto Color Emoji" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
