{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        title = "Terminal";

        padding = { x = 2;y = 2; };

        dimensions = {
          lines = 75;
          columns = 100;
        };
      };

      font = {
        normal.family = "JetbrainsMono Nerd Font";
        size = 12.0;
      };

      background_opacity = 1;

      shell = { program = "${pkgs.zsh}/bin/zsh"; };

      colors = {
        primary = {
	        background = "0x1a1b26";
      foreground = "0xa9b1d6";
        };
        cursor = {
          text = "0xFF261E";
          cursor = "0xFF261E";
        };
        normal = {
              black =   "0x32344a";
      red =     "0xf7768e";
      green =   "0x9ece6a";
      yellow =  "0xe0af68";
      blue =    "0x7aa2f7";
      magenta = "0xad8ee6";
      cyan =    "0x449dab";
      white =   "0x787c99";
	};
        bright = {
	        black =   "0x444b6a";
      red=     "0xff7a93";
      green=   "0xb9f27c";
      yellow=  "0xff9e64";
      blue=    "0x7da6ff";
      magenta= "0xbb9af7";
      cyan=   "0x0db9d7";
      white=   "0xacb0d0";
        };
	selection = {text = "#EBCB8B";save_to_clipboard = true;};
      	scrolling = {history = 10000;multiplier = 10;};
	draw_bold_text_with_bright_colors = true;


      };
    };
  };
}
