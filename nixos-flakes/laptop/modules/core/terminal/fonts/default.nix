{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    noto-fonts-extra
    nerdfonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];
  fontconfig.defaultFonts = {
    serif = [ "JetBrains Mono" "Noto Color Emoji" ];
    sansSerif = [ "JetBrains Mono" "Noto Color Emoji" ];
    mono = [ "JetBrains Mono" ];
    emoji = [ "Noto Color Emoji" ];
  };
}
