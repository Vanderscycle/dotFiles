{
  steppe,
  ...
}:
{
  steppe.theming = {
    includes = [ (steppe.theming._.catppuccin "mocha" "mauve") ];
    nixos =
      { pkgs, ... }:
      {
        fonts = {
          packages = with pkgs; [
            maple-mono.NF
            jetbrains-mono
            montserrat
            libertine
            inter
            noto-fonts
            openmoji-color
            nerd-fonts.symbols-only
            atkinson-hyperlegible-next
            noto-fonts
            noto-fonts-cjk-sans
            noto-fonts-cjk-serif
            # You might also want these for your Mandarin learning
            source-han-sans
            source-han-serif
          ];
          enableDefaultPackages = true;
          fontDir.enable = true;
          fontconfig = {
            enable = true;
            defaultFonts = {
              # serif = [
              #   "Noto Serif CJK SC"
              #   "Noto Serif"
              # ];
              # sansSerif = [
              #   "Noto Sans CJK SC"
              #   "Noto Sans"
              # ];
              # monospace = [
              #   "Noto Sans Mono CJK SC"
              #   "JetBrainsMono Nerd Font"
              # ];
              sansSerif = [ "Atkinson Hyperlegible Next" ];
              serif = [ "Liberation Serif" ];
              monospace = [
                "JetBrainsMono Nerd Font"
                "Maple Mono NF"
              ];
              emoji = [ "OpenMoji Color" ];
            };
          };
        };
      };

    homeManager =
      { pkgs, config, ... }:
      {
        gtk.gtk4.theme = config.gtk.theme;
        home.pointerCursor = {
          package = pkgs.posy-cursors;
          name = "Posy_Cursor";
          gtk.enable = true;
        };
      };
  };
}
