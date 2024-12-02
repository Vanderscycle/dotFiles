{
  pkgs,
  ...
}:
{
    programs.waybar = {
      enable = true;
      style = ''

        /*
        *
        * Catppuccin Mocha palette
        * Maintainer: rubyowo
        *
        */

        @define-color base   #1e1e2e;
        @define-color mantle #181825;
        @define-color crust  #11111b;

        @define-color text     #cdd6f4;
        @define-color subtext0 #a6adc8;
        @define-color subtext1 #bac2de;

        @define-color surface0 #313244;
        @define-color surface1 #45475a;
        @define-color surface2 #585b70;

        @define-color overlay0 #6c7086;
        @define-color overlay1 #7f849c;
        @define-color overlay2 #9399b2;

        @define-color blue      #89b4fa;
        @define-color lavender  #b4befe;
        @define-color sapphire  #74c7ec;
        @define-color sky       #89dceb;
        @define-color teal      #94e2d5;
        @define-color green     #a6e3a1;
        @define-color yellow    #f9e2af;
        @define-color peach     #fab387;
        @define-color maroon    #eba0ac;
        @define-color red       #f38ba8;
        @define-color mauve     #cba6f7;
        @define-color pink      #f5c2e7;
        @define-color flamingo  #f2cdcd;
        @define-color rosewater #f5e0dc;

        /* Global */
        * {
          font-family: "JetBrainsMono Nerd Font";
          font-size: .9rem;
          border-radius: 1rem;
          transition-property: background-color;
          transition-duration: 0.5s;
          background-color: shade(@base, 0.9);
        }

        @keyframes blink_red {
          to {
            background-color: @red;
            color: @base;
          }
        }

        .warning, .critical, .urgent {
          animation-name: blink_red;
          animation-duration: 1s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
        }

        #mode, #clock, #memory, #temperature, #cpu,
        #mpd, #idle_inhibitor, #backlight, #pulseaudio, #network,
        #battery, #custom-powermenu, #custom-cava-internal,
        #custom-launcher, #tray, #disk, #custom-pacman, #custom-scratchpad-indicator {
          padding-left: .6rem;
          padding-right: .6rem;
        }

        /* Bar */
        window#waybar {
          background-color: transparent;
        }

        window > box {
          background-color: transparent;
          margin: .3rem;
          margin-bottom: 0;
        }


        /* Workspaces */
        #workspaces:hover {
          background-color: @green;
        }

        #workspaces button {
          padding-right: .4rem;
          padding-left: .4rem;
          padding-top: .1rem;
          padding-bottom: .1rem;
          color: @red;
          /* border: .2px solid transparent; */
          background: transparent;
        }

        #workspaces button.active {
          color: @blue;
        }

        #workspaces button:hover {
          /* border: .2px solid transparent; */
          color: @rosewater;
        }

        /* Tooltip */
        tooltip {
          background-color: @base;
        }

        tooltip label {
          color: @rosewater;
        }

        /* battery */
        #battery {
          color: @mauve;
        }
        #battery.full {
          color: @green;
        }
        #battery.charging{
          color: @teal;
        }
        #battery.discharging {
          color: @peach;
        }
        #battery.critical:not(.charging) {
          color: @pink;
        }
        #custom-powermenu {
          color: @red;
        }

        /* mpd */
        #mpd.paused {
          color: @pink;
          font-style: italic;
        }
        #mpd.stopped {
          color: @rosewater;
          /* background: transparent; */
        }
        #mpd {
          color: @lavender;
        }

        /* Extra */
        #custom-cava-internal{
          color: @peach;
          padding-right: 1rem;
        }
        #custom-launcher {
          color: @yellow;
        }
        #memory {
          color: @peach;
        }
        #cpu {
          color: @blue;
        }
        #clock {
          color: @rosewater;
        }
        #idle_inhibitor {
          color: @green;
        }
        #temperature {
          color: @sapphire;
        }
        #backlight {
          color: @green;
        }
        #pulseaudio {
          color: @mauve;  /* not active */
        }
        #network {
          color: @pink; /* not active */
        }
        #network.disconnected {
          color: @foreground;  /* not active */
        }
        #disk {
          color: @maroon;
        }
        #custom-pacman{
          color: @sky;
        }
        #custom-scratchpad-indicator {
          color: @yellow
        }
      '';
      settings = {
        mainBar = {
          layer = "top";
          modules-left = [
            "custom/launcher"
            "hyprland/workspaces"
            "temperature"
            "pulseaudio"
            "idle_inhibitor"
            "hyprland/submap"
          ];
          modules-center = [ "clock" ];
          modules-right = [
            "backlight"
            "disk"
            "mnt_disk"
            "memory"
            "cpu"
            "network"
            "battery"
            "tray"
          ];
          "custom/launcher" = {
            format = "";
            on-click = "fuzzel --background-color=1e1e2eff --text-color=cdd6f4ff --border-color=cba6f7ff";
            tooltip-format = "";
            tooltip = false;
          };
          "hyprland/submap" = {
            format = " {}";
          };
          "hyprland/workspaces" = {
            format = "{icon}";
            on-scroll-up = "hyprctl dispatch workspace e+1";
            on-scroll-down = "hyprctl dispatch workspace e-1";
            format-icons = {
              "1" = "一";
              "2" = "二";
              "3" = "三";
              "4" = "四";
              "5" = "五";
              "6" = "六";
              "7" = "七";
              "8" = "八";
              "9" = "九";
              "10" = "十";
              urgent = "";
              focused = "";
              default = "";
            };
          };
          idle_inhibitor = {
            format = "{icon}";
            format-icons = {
              activated = "";
              deactivated = "";
            };
            tooltip = false;
          };
          disk = {
            interval = 30;
            format = " {used}";
            path = "/home/${username}/";
            tooltip = true;
            tooltip-format = "{used}/{total} => {path} {percentage_used}%";
          };
          mnt_disk = {
            interval = 30;
            format = " {used}";
            path = "/mnt/backup";
            tooltip = true;
            tooltip-format = "{used}/{total} => {path} {percentage_used}%";
          };
          pulseaudio = {
            scroll-step = 1;
            format = "{icon} {volume}%";
            format-muted = "婢 Muted";
            format-icons = {
              default = [
                ""
                ""
                ""
              ];
            };
            on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
            tooltip = false;
          };
          battery = {
            interval = 10;
            states = {
              warning = 20;
              critical = 10;
            };
            format = "{icon} {capacity}%";
            format-icons = [
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
            ];
            format-full = "{icon} {capacity}%";
            format-charging = " {capacity}%";
            tooltip = true;
          };
          clock = {
            on-click = "~/.config/waybar/to_latte.sh &";
            on-click-right = "~/.config/waybar/wallpaper_random.sh &";
            on-click-middle = "~/.config/waybar/live_wallpaper.sh &";
            interval = 1;
            format = "{:%I:%M %p  %A %b %d}";
            tooltip = true;
            tooltip-format = "{:%A, %d %B %Y}\n<tt>{calendar}</tt>";
          };
          memory = {
            on-click = "kitty btm";
            interval = 1;
            format = "﬙ {percentage}%";
            states = {
              warning = 85;
            };
          };
          cpu = {
            interval = 1;
            format = " {usage}%";
          };
          network = {
            interval = 1;
            format-wifi = "說 {essid}";
            format-ethernet = "  {ifname} ({ipaddr})";
            format-linked = "說 {essid} (No IP)";
            format-disconnected = "說 Disconnected";
            tooltip = false;
          };
          temperature = {
            hwmon-path = "/sys/devices/virtual/thermal/thermal_zone0/temp";
            tooltip = true;
            format = " {temperatureC}°C";
          };
          # TODO: refactori
          "custom/powermenu" = {
            format = "";
            on-click = "~/.config/rofi/powermenu.sh";
            tooltip = false;
          };
          tray = {
            icon-size = 15;
            spacing = 5;
          };
          # TODO: get a layout switcher
          "sway/language" = {
            format = "{}";
            on-click = "swaymsg input type:keyboard xkb_switch_layout next";
          };
        };
      };
    };
}
