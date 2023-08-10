{ config, pkgs, ... }:

let
  dotfiles_dir = /home/henri/Documents/dotFiles;
  inherit (config.lib.formats.rasi) mkLiteral;
  theme = import ../themes;
in
{
  programs.rofi = {
    enable = true;
    # font = "IosevkaTerm Nerd Font 9";
    # terminal = "st";
    extraConfig = {
      "location" = 5;
      "modi" = "drun,run";
      "display-drun" = "";
      "display-run" = "";
      "drun-display-format" = "{name}";
      "show-icons" = false;
    };
    theme = {
      "*" = {
        bg = mkLiteral theme.base00;
        fg = mkLiteral theme.base01;
        al = mkLiteral theme.base02;
        background-color = mkLiteral "@bg";
        text-color = mkLiteral "@fg";
      };
      window = {
        border = mkLiteral "0px";
        height = mkLiteral "40px";
        width = mkLiteral "100%";
        padding = mkLiteral "0px";
      };
      mainbox = {
        children = map mkLiteral [ "inputbar" ];
        background-color = mkLiteral "@bg";
        margin = mkLiteral "0px 20px 0px 20px";
      };
      prompt = {
        text-color = mkLiteral "@fg";
        enabled = mkLiteral "true";
        padding = mkLiteral "13px 13px 13px 0px";
      };
      inputbar = {
        children = map mkLiteral [ "prompt" "textbox-prompt-divider" "entry" "listview" ];
        spacing = mkLiteral "0";
      };
      listview = {
        background-color = mkLiteral "@bg";
        lines = mkLiteral "100";
        cycle = mkLiteral "true";
        layout = mkLiteral "horizontal";
        horizontal-align = mkLiteral "0.5";
      };
      entry = {
        background-color = mkLiteral "@bg";
        padding = mkLiteral "13px 10px 13px 10px";
        text-color = mkLiteral "@fg";
        placeholder-color = mkLiteral "@fg";
        placeholder = mkLiteral ''"Search..."'';
        horizontal-align = mkLiteral "0";
        expand = mkLiteral "false";
        width = mkLiteral "17.5%";
        cursor = mkLiteral "text";
      };
      element = {
        text-color = mkLiteral "@fg";
        padding = mkLiteral "10px 10px 8px 10px";
        expand = mkLiteral "false";
        cursor = mkLiteral "pointer";
        margin = mkLiteral "3px";
        border-radius = mkLiteral "4px";
      };
      "element.selected" = {
        text-color = mkLiteral "@fg";
        background-color = mkLiteral "@al";
      };
      element-text = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
        cursor = mkLiteral "pointer";
      };
      "element-text selected" = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
        cursor = mkLiteral "pointer";
        highlight = mkLiteral "none";
      };
      textbox-prompt-divider = {
        expand = mkLiteral "false";
        str = mkLiteral ''"::"'';
        text-color = mkLiteral "@fg";
        padding = mkLiteral "13px 0px 13px 0px";
      };
    };
  };

  home = {
    file = {

      ".config/rofi/powermenu.sh".source = "${dotfiles_dir}/.config/rofi/bin/powermenu";
      ".config/rofi/confirm.rasi".text = ''
        @import "colors.rasi"
        @import "font.rasi"

        * {
            background-color:       @BG;
            text-color:             @FG;
        }

        window {
            width:      	        200px;
            padding:                20px;
            border:		            0px 0px 2px 0px;
            border-radius:          8px;
            border-color:           @BDR;
            location:               0;
            x-offset:               0;
            y-offset:               -4%;
        }

        entry {
            expand: 		        true;
            width: 		            150px;
            text-color:		        @BDR;
        }
      '';
      ".config/rofi/font.rasi".text = ''
        * {
            font:				 	"JetBrainsMone 16";
        }
      '';
      ".config/rofi/colors.rasi".text = ''
        * {
            BG:    #1E1D2Fff;
            BGA:   #89DCEBff;
            FG:    #D9E0EEff;
            FGA:   #F28FADff;
            BDR:   #96CDFBff;
            SEL:   #1E1E2Eff;
            UGT:   #F28FADff;
            IMG:   #FAE3B0ff;
            OFF:   #575268ff;
            ON:    #ABE9B3ff;
        }
      '';
      ".config/rofi/poww.rasi".text = ''
            configuration {
    	    font:   "Material Design Icons Desktop 18";
    	    disable-history:    false;
    	    sidebar-mode:   false;
    	    show-icons:    false;
            }
            @theme "/dev/null"
            * {
                bg:	    ${theme.base00};
                lg:	    ${theme.base02};
                fg:	    ${theme.base01};
                se:     ${theme.base06};
                background-color:   @bg;
                text-color:     @fg;
            }
            window {
                transparency:   "real";
                border-radius:  4px;
                location:   center;
                width:      400px;
            }
            listview {
                columns:	5;
                lines:	1;
                spacing:    12px;
                cycle:      true;
                dynamic:    true;
                layout:     vertical;
            }
            mainbox {
                children:	[ listview ];
                spacing:	20px;
                margin:	20px;
            }
            element {
                background-color:   @lg;
                border-radius:      4px;
            }
            element-text {
                background-color:   inherit;
                text-color:       	inherit;
                expand:             true;
                horizontal-align:   0.5;
                vertical-align:     0.5;
                margin:             15px 15px 15px 10px;
            }
            element selected {
                text-color: 	@bg;
                background-color:   @se;
                border-radius:      4px;
            }
  '';

      ".config/rofi/powermenu.rasi".text = ''
        configuration {
            show-icons:                     true;
            display-drun: 		            "";
            drun-display-format:            "{icon} {name}";
            disable-history:                false;
            click-to-exit: 		            true;
            location:                       4;
        }

        @import "font.rasi"
        @import "colors.rasi"

        /* Line Responsible For Button Layouts */
        /* BUTTON = TRUE */

        window {
            transparency:                   "real";
            background-color:               @BG;
            text-color:                     @FG;
            border:                  	    2px;
            border-color:                   @BGA;
            border-radius:                  10px;
            width:                          110px;
            x-offset:                       -1%;
            y-offset:                       0;
        }

        prompt {
            enabled: 			            true;
            margin: 			            0px 0px 0px 8px;
            padding: 			            8px;
            background-color: 		        @BG;
            text-color: 		            @FG;
            border:                  	    0px 0px 2px 0px;
            border-color:                   @BDR;
            border-radius:                  10px;
        }
        textbox-prompt-colon {
            expand: 			            false;
            str: 			                "";
            border-radius:                  100%;
            background-color:               @BG;
            text-color:                     @BG;
            padding:                        8px 12px 8px 12px;
            font:			                "Iosevka Nerd Font 10";
        }

        entry {
            background-color:               @BG;
            text-color:                     @FG;
            placeholder-color:              @FG;
            expand:                         true;
            horizontal-align:               0;
            placeholder:                    "Search...";
            blink:                          true;
            border:                  	    0px 0px 2px 0px;
            border-color:                   @BDR;
            border-radius:                  10px;
            padding:                        8px;
        }

        inputbar {
            children: 		                [ textbox-prompt-colon ];
            background-color:               @BG;
            text-color:                     @FG;
            expand:                         false;
            border:                  	    0px 0px 0px 0px;
            border-radius:                  0px;
            border-color:                   @BDR;
            margin:                         0px 0px 0px 0px;
            padding:                        0px;
            position:                       center;
        }

        case-indicator {
            background-color:               @BG;
            text-color:                     @FG;
            spacing:                        0;
        }


        listview {
            background-color:               @BG;
            columns:                        1;
            lines:			                5;
            spacing:                        15px;
            cycle:                          true;
            dynamic:                        true;
            layout:                         vertical;
        }

        mainbox {
            background-color:               @BG;
            children:                       [ listview ];
            spacing:                        15px;
            padding:                        15px;
        }

        element {
            background-color:               @BG;
            text-color:                     @FG;
            orientation:                    horizontal;
            border-radius:                  10px;
            padding:                        20px;
        }

        element-icon {
            background-color: 		        inherit;
            text-color:       		        inherit;
            horizontal-align:               0.5;
            vertical-align:                 0.5;
            size:                           0px;
            border:                         0px;
        }

        element-text {
            background-color: 		        inherit;
            text-color:       		        inherit;
            font:			                "feather 20";
            expand:                         true;
            horizontal-align:               0.5;
            vertical-align:                 0.5;
            margin:                         0px 0px 0px 0px;
        }

        element selected {
            background-color:               @BGA;
            text-color:                     @SEL;
            border:                  	    0px 0px 0px 0px;
            border-radius:                  10px;
            border-color:                   @BDR;
        }

        element.active,
        element.selected.urgent {
          background-color: @ON;
          text-color: @BG;
          border-color: @ON;
        }

        element.selected.urgent {
          border-color: @BDR;
        }

        element.urgent,
        element.selected.active {
          background-color: @OFF;
          text-color: @BG;
          border-color: @OFF;
        }

        element.selected.active {
          border-color: @BDR;
        }
      '';
    };
  };
}
