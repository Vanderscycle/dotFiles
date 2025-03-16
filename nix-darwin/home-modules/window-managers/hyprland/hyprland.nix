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
        env = HYPRCURSOR_THEME,rose-pine-hyprcursor
        env = XCURSOR_THEME,rose-pine-hyprcursor
        env = HYPRCURSOR_SIZE,32

        # Emacs programs launched using the key chord SUPER+e followed by 'key'
        bind = $mainMod, E, submap, emacs # will switch to a submap called 'emacs'
        submap = emacs # will start a submap called "emacs"
        # sets repeatable binds for resizing the active window
        binde = , E, exec, $reset $emacs
        binde = , D, exec, $reset $emacs --eval '(dired "~/Documents/dotFiles/nix-darwin")'
        # binde = , P, exec, $reset $emacs --eval '(progn (require "\"'projectile) (projectile-add-known-project "~/Documents/dotFiles/nix-darwin") (projectile-switch-project-by-name "~/Documents/dotFiles/nix-darwin"))'
        binde = , N, exec, $reset $emacs --eval '(find-file "~/Documents/zettelkasten/org-roam/20240828204250-knowlege_base.org")'
        binde = , B, exec, $reset $emacs --eval '(ibuffer)'
        binde = , H, exec, $reset $emacs --eval '(dired nil)'
        binde = , S, exec, $reset $emacs --eval '(eshell)'
        binde = , V, exec, $reset $emacs --eval '(vterm)'
        binde = , F4, exec, $reset killall emacs
        # use reset to go back to the global submap
        bind = , escape, submap, reset
        # will reset the submap, which will return to the global submap
        submap = reset


        bind = $mainMod, P, submap, programs
        submap = programs
        # sets repeatable binds for resizing the active window
        binde = , T, exec, $reset $filemanager
        binde = , Q, exec, $reset $terminal
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
        "$menu" = "fuzzel --background-color=1e1e2eff --text-color=cdd6f4ff --border-color=cba6f7ff";
        "$emacs" = "emacsclient -c -a 'emacs' "; # The space at the end is IMPORTANT!
        "$reset" = "hyprctl dispatch submap reset &&"; # use a variable to keep things more readable

        input = {
          kb_layout = "us";

          follow_mouse = 0; # focus change on cursor move
          accel_profile = "flat";
        };

        #####################
        ### LOOK AND FEEL ###
        #####################

        # Refer to https://wiki.hyprland.org/Configuring/Variables/

        # https://wiki.hyprland.org/Configuring/Variables/#general

        general = {
          gaps_in = 7;
          gaps_out = 20;
          border_size = 2;
          layout = "dwindle";
        };
        # https://wiki.hyprland.org/Configuring/Variables/#decoration
        decoration = {
          blur = {
            enabled = true;
            size = 8;
            passes = 1;
            new_optimizations = true;
          };
          rounding = 10;
        };
        animations = {
          enabled = "yes";
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "border, 1, 2, default"
            "fade, 1, 4, default"
            "windows, 1, 3, default, popin 80%"
            "workspaces, 1, 2, default, slide"
          ];
        };
        # https://wiki.hyprland.org/Configuring/Dwindle-Layout/
        dwindle = {
          pseudotile = "yes";
          preserve_split = "yes";
        };

        # master = {
        #   new_is_master = true; # new window become the active window
        # };
        # https://wiki.hyprland.org/Configuring/Variables/#gestures
        gestures = {
          workspace_swipe = "off";
        };
        # https://wiki.hyprland.org/Configuring/Keywords/

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
            "SHIFTSUPER, O, exec, grim -g '$(slurp)' ~/Pictures/screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png"
            "SHIFTSUPER, O, exec, flameshot gui --clipboard"
            # "SHIFTSUPER, Q, exec, $emacs --eval '(vterm)'"

            # scripts
            # "$mainMod, f, exec, ${lib.getExe myScript}"
            # volume control
            "$mainMod SHIFT, minus, exec, amixer -q sset Master 5%-"
            "$mainMod CTRL, minus, exec, amixer -q sset Master 5%+"
            # buffer manipulation
            "$mainMod SHIFT, F, fullscreen,"
            "$mainMod, D, pseudo"
            "$mainMod, S, togglesplit"
            "$mainMod, C, killactive,"
            "$mainMod, V, togglefloating,"
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
          "workspace 1, Emacs"
          "workspace 2, firefox"
          "workspace 2, Brave-browser" # Updated to match the class name for Brave
          "workspace 3, discord"
          "workspace 3, Spotify"
          "workspace 3, spotify"
          "workspace 4, steam"
          "workspace 4, Steam"
          "workspace 4, heroic"
          "workspace 5, SuperSlicer"
          "workspace 5, OrcaSlicer"
          "workspace 6, transmission-gtk" # Updated to match the class name for Transmission
          "pseudo,fcitx"
        ];

        windowrulev2 = [
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
          "float, class:^(org.fcitx5.)$"
        ];
        #################
        ### AUTOSTART ###
        #################

        # Autostart necessary processes (like notifications daemons, status bars, etc.)
        # Or execute your favorite apps at launch like this:

        exec-once = [
          "sleep 1 && waybar"
          "hyprpaper"
          "Emacs"
          "blueman-applet"
          # "/etc/profiles/per-user/henri/bin/emacs --daemon &"
          "swaync"
          "discord --enable-wayland-ime"
          "spotify"
          "Brave --enable-wayland-ime"
          "kitty"
          "flameshot"
          "fcitx5"
          # "emacs" # TODO: make it spawn out of a shell
        ];
      };
    };
  };
}
