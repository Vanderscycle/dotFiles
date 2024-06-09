{ pkgs, ... }:

{
  # Fonts
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-font-patcher
    noto-fonts
    noto-fonts-cjk
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-extra
    nerdfonts
  ];
}
# TODO: fix chinese characters
# {
#   fonts = {
#     packages = with pkgs; [
#       nerdfonts
#       noto-fonts
#       noto-fonts-cjk
#       noto-fonts-emoji
#       roboto
#     ];
#     fontconfig.defaultFonts = {
#       serif = [ "Roboto Serif" "Noto Color Emoji" ];
#       sansSerif = [ "Roboto" "Noto Color Emoji" ];
#       emoji = [ "Noto Color Emoji" ];
#     };
#   };
# }
