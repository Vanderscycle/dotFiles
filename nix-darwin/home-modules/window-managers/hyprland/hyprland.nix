{
  pkgs,
  ...
}:
{

  catppuccin.hyprland.enable = true;
  wayland.windowManager = {
    hyprland = {
      enable = true; # allow home-manager to configure hyprland
      # https://github.com/nix-community/home-manager/issues/6062
      extraConfig = ''
        ecosystem:no_update_news = true

        env = BROWSER,brave
        env = DEFAULT_BROWSER,brave

        env = HYPRCURSOR_THEME,rose-pine-hyprcursor
        env = HYPRCURSOR_SIZE,32
        # old
        env = XCURSOR_THEME,rose-pine-hyprcursor
        env = XCURSOR_SIZE,32

        # Emacs programs launched using the key chord SUPER+e followed by 'key'
        bind = $mainMod, E, submap, emacs # will switch to a submap called 'emacs'
        submap = emacs # will start a submap called "emacs"
        # sets repeatable binds for resizing the active window
        binde = , E, exec, $reset emacsclient -c
        binde = , V, exec, $reset emacsclient -r -e '(my/new-frame-with-vterm)'
        binde = , K, exec, $reset emacsclient -r -e '(progn (select-frame-set-input-focus (selected-frame)) (+calendar/open-calendar))'
        binde = , c, exec, $reset emacsclient -r -e '(progn (select-frame-set-input-focus (selected-frame)) (org-capture)))'
        # use reset to go back to the global submap
        bind = , escape, submap, reset
        # will reset the submap, which will return to the global submap
        submap = reset


        bind = $mainMod, P, submap, programs
        submap = programs
        # sets repeatable binds for resizing the active window
        binde = , T, exec, $reset $filemanager
        binde = , Q, exec, $reset $terminal
        binde = , P, exec, $reset hyprpicker -a
        # use reset to go back to the global submap
        bind = , escape, submap, reset
        # will reset the submap, which will return to the global submap
        submap = reset

      '';
      settings = {
        ###################
        ### MY PROGRAMS ###
        ###################

        # See https://wiki.hyprland.org/Configuring/Keywords/

        # Set programs that you use

        "$mainMod" = "SUPER";
        "$terminal" = "kitty";
        "$filemanager" = "thunar";
        # fuzzel/wofi do not pass env vars hence why emacs does not get $SSH_AUTH_SOCK. you must start from cli
        "$menu" = "fuzzel --background-color=1e1e2eff --text-color=cdd6f4ff --border-color=cba6f7ff";
        # "$menu" = "wofi --show drun";
        "$emacs" = "emacsclient -n -e"; # The space at the end is IMPORTANT!
        "$reset" = "hyprctl dispatch submap reset &&"; # use a variable to keep things more readable

        input = {
          kb_layout = "us,fr";
          kb_options = "grp:caps_toggle";
          follow_mouse = 0; # focus change on cursor move
          accel_profile = "flat";
          repeat_delay = 300;
          repeat_rate = 70;
        };

        #####################
        ### LOOK AND FEEL ###
        #####################

        # Refer to https://wiki.hyprland.org/Configuring/Variables/

        # https://wiki.hyprland.org/Configuring/Variables/#general

        general = {
          gaps_in = 7;
          gaps_out = 10;
          border_size = 2;
          layout = "dwindle";
        };
        # https://wiki.hyprland.org/Configuring/Variables/#decoration
        decoration = {
          active_opacity = 1;
          inactive_opacity = 0.85;

          blur = {
            enabled = true;
            size = 8;
            passes = 1;
            new_optimizations = true;
            ignore_opacity = true;
          };
          rounding = 10;
        };
        animations = {
          enabled = "yes";
          bezier = [
            "myBezier, 0.05, 0.7, 0.1, 1.0"
            "easeOutQuint, 0.22, 1, 0.36, 1"
          ];
          animation = [
            # Increased durations to make animations more noticeable
            "windows, 0.7, 4, myBezier, popin"
            "windowsOut, 0.6, 3, default, popin 80%"
            "border, 0.4, 3, default"
            "fade, 0.4, 3, default"
            "workspaces, 0.8, 3, easeOutQuint, slide"
          ];
        };
        # https://wiki.hyprland.org/Configuring/Dwindle-Layout/
        dwindle = {
          pseudotile = "yes";
          preserve_split = "yes";
        };

        ###################
        ### KEYBINDINGS ###
        ###################

        bind =
          let
            myScript = pkgs.writeShellScriptBin "hallo" ''
              ${pkgs.libnotify}/bin/notify-send "hello world"
            '';
          in
          [
            "$mainMod, h, movefocus, l"
            "$mainMod, l, movefocus, r"
            "$mainMod, k, movefocus, u"
            "$mainMod, j, movefocus, d"
            # Move window around the stack with SUPER + ALT + h/j/k/l
            "$mainMod ALT, H, movewindow, l"
            "$mainMod ALT, L, movewindow, r"
            "$mainMod ALT, K, movewindow, u"
            "$mainMod ALT, J, movewindow, d"
            # resize window
            "$mainMod SHIFT, h, resizeactive, -120 0"
            "$mainMod SHIFT, l, resizeactive, 120 0"
            "$mainMod SHIFT, k, resizeactive, 0 -120"
            "$mainMod SHIFT, j, resizeactive, 0 120"
            # launch program menu
            "SHIFTSUPER, P, exec, $menu"
            # "SHIFTSUPER, O, exec, grim -g '$(slurp)' ~/Pictures/screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png" # idk, flameshot doesn't work wihtout this
            # "SHIFTSUPER, V, exec, cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"
            "SHIFTSUPER, O, exec, flameshot gui --clipboard"

            # scripts
            # "$mainMod, f, exec, ${lib.getExe myScript}"
            "$mainMod SHIFT, space, exec,emacsclient -n -e `(progn (load \"/home/henri/Documents/dotFiles/template.el\") (select-frame-set-input-focus (selected-frame)) (universal-launcher-popup))`"
            # volume control
            # doesn't work
            "$mainMod SHIFT, minus, exec, amixer -q sset Master 5%-"
            "$mainMod CTRL, minus, exec, amixer -q sset Master 5%+"
            # buffer manipulation
            "$mainMod CTRL, F, fullscreen,"
            "$mainMod CTRL, D, pseudo" # dwindle
            "$mainMod CTRL, S, togglesplit" # dwindle
            "$mainMod CTRL, TAB, cyclenext"
            "$mainMod, Q, killactive,"
            "$mainMod, F, togglefloating,"
            # Switch workspaces with mainMod + [0-9]
            "$mainMod, 1, workspace, 1"
            "$mainMod, 2, workspace, 2"
            "$mainMod, 3, workspace, 3"
            "$mainMod, 4, workspace, 4"
            "$mainMod, 5, workspace, 5"
            "$mainMod, 6, workspace, 6"
            "$mainMod, 7, workspace, 7"
            "$mainMod, 8, workspace, 8"
            "$mainMod, 9, workspace, 9"
            "$mainMod, 0, workspace, 10"
            # Move active window to a workspace with mainMod + SHIFT + [0-9]
            "$mainMod SHIFT, 1, movetoworkspace, 1"
            "$mainMod SHIFT, 2, movetoworkspace, 2"
            "$mainMod SHIFT, 3, movetoworkspace, 3"
            "$mainMod SHIFT, 4, movetoworkspace, 4"
            "$mainMod SHIFT, 5, movetoworkspace, 5"
            "$mainMod SHIFT, 6, movetoworkspace, 6"
            "$mainMod SHIFT, 7, movetoworkspace, 7"
            "$mainMod SHIFT, 8, movetoworkspace, 8"
            "$mainMod SHIFT, 9, movetoworkspace, 9"
            "$mainMod SHIFT, 0, movetoworkspace, 10"
          ];
        bindm = [
          # Move/resize windows with mainMod + LMB/RMB and dragging
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];
        bindl = [
          # media controls
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
          ", XF86AudioNext, exec, playerctl next"

          # volume
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ];
        # hyprctl clients
        windowrule = [
        ];

        windowrulev2 = [
          # Workspace rules
          "workspace 1, class:^(Emacs)$"
          "workspace 2, class:^(firefox|brave-browser)$"
          "workspace 3, class:^(discord|Spotify|spotify|Proton Pass)$"
          "workspace 7, class:^(Proton Pass)$"
          "workspace 4, class:^(?i)steam|heroic$" # Case-insensitive match
          "workspace 5, class:^(SuperSlicer|OrcaSlicer)$"
          "workspace 6, class:^(transmission-gtk)$"
          # Steam rules
          "stayfocused, title:^()$,class:^(steam)$" # otherwise it closes post launching a game
          "float, class:^([Ss]team)$, title:^((?![Ss]team).*)$" # Float non-Steam windows (e.g., game launchers)
          "workspace 4 silent, class:^([Ss]team)$, title:^([Ss]team)$" # Move Steam to workspace 4
          "tile, class:^([Ss]team)$, title:^([Ss]team)$" # Tile the main Steam window
          # "workspace 4 silent, class:^([Ss]team)$, title:^(notificationtoasts_.*)$" # Move Steam notifications to workspace 4
          "nofocus, class:^([Ss]team)$, title:^((?![Ss]team).*)$" # Prevent non-Steam windows from stealing focus
          "noblur, class:^([Ss]team)$" # Ensure Steam window remains visible
          # orcaslicer
          # https://github.com/hyprwm/Hyprland/issues/6698
          "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
          "noanim,class:^(xwaylandvideobridge)$"
          "nofocus,class:^(xwaylandvideobridge)$"
          "noinitialfocus,class:^(xwaylandvideobridge)$"
          # fcitx
          "float, class:^(org\\.fcitx5\\..*)$"
          "pseudo, class:^(fcitx)$"
        ];
        #################
        ### AUTOSTART ###
        #################
        # Autostart necessary processes (like notifications daemons, status bars, etc.)
        # Or execute your favorite apps at launch like this:

        exec-once = [
          "sleep 1 && waybar"
          "hyprpaper"
          "emacsclient -r"
          "blueman-applet"
          "swaync"
          "spotify"
          "brave"
          "flameshot"
          "copyq --start-server"
          "fcitx5"
          "proton-pass"
          "wl-paste --watch cliphist store" # https://wiki.hypr.land/Useful-Utilities/Clipboard-Managers/
        ];
      };
    };
  };
}
