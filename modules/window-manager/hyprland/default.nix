{ inputs, __findFile, ... }:
{
  steppe.window-manager._.hyprland = {
    includes = [
      <steppe/status-bar/waybar>
      <steppe/program/hyprpaper>
      # <steppe/program/hypridle>
      <steppe/program/swaync>
      <steppe/program/thunar>
      <steppe/program/fuzzel>
      <steppe/program/flameshot>
      <steppe/program/fcitx>
      <steppe/program/kitty>
      <steppe/program/wezterm>
    ];
    nixos =
      { pkgs, ... }:
      {
        programs.dconf.enable = true;
        programs.appimage = {
          enable = true;
          binfmt = true;
        };
        services = {
          displayManager = {
            enable = true;
          };
          greetd = {
            enable = true;
            settings = {
              initial_session = {
                command = "start-hyprland"; # "uwsm start hyprland.desktop";
                user = "khan";
              };
              default_session = {
                command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd 'start-hyprland'";
                user = "greeter";
              };
            };
          };
        };
        environment = {
          systemPackages = with pkgs; [
            wl-clipboard
            hyprcursor
            hyprpicker
          ];
          sessionVariables = {
          };
        };
        programs = {
          # uwsm = {
          #   enable = true;
          #   waylandCompositors = {
          #     hyprland = {
          #       prettyName = "Hyprland";
          #       comment = "Hyprland compositor managed by UWSM";
          #       binPath = "/run/current-system/sw/bin/Hyprland";
          #     };
          #   };
          # };
          hyprland = {
            enable = true;
            # withUWSM = true;
            package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
            portalPackage =
              inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
          };
        };
      };
    homeManager =
      { config, pkgs, ... }:
      let
        mkOutOfStoreSymlink = path: config.lib.file.mkOutOfStoreSymlink path;
        configDir = "${config.home.homeDirectory}/Documents/dotFiles";
      in
      {

        home = {
          file = {
            ".config/hypr/scripts".source =
              mkOutOfStoreSymlink "${configDir}/modules/window-manager/hyprland/scripts";
          };
          packages = with pkgs; [
            inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
            playerctl
            wf-recorder # video recorder for wayland
          ];
        };
        wayland.windowManager = {
          hyprland = {
            enable = true;
            # xwayland.enable = true;
            systemd.enable = true; # uwsm
            # package = null;
            # portalPackage = null;
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
              binde = , V, exec, $reset emacsclient -n -e '(my/new-frame-with-vterm)'
              binde = , K, exec, $reset ~/.config/hypr/scripts/emacs-launcher '(progn (select-frame-set-input-focus (selected-frame)) (calfw-org-open-calendar))'
              binde = , c, exec, $reset ~/.config/hypr/scripts/emacs-launcher '(progn (select-frame-set-input-focus (selected-frame)) (org-capture))'
              binde = , F, exec, $reset ~/.config/hypr/scripts/emacs-launcher '(progn (select-frame-set-input-focus (selected-frame)) (dirvish))'
              binde = , space, exec, $reset ~/.config/hypr/scripts/emacs-launcher '(progn (select-frame-set-input-focus (selected-frame)) (universal-launcher-popup))'
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
              monitor = [
                # Syntax: name, resolution@refresh, position, scale
                "HDMI-A-1, 3440x1440@99, 0x0, 1"
              ];
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
              cursor = {
                no_hardware_cursors = true;
              };
              general = {
                gaps_in = 7;
                gaps_out = 10;
                border_size = 2;
                layout = "dwindle";
              };
              dwindle = {
                pseudotile = "yes";
                preserve_split = "yes";
                smart_split = false; # no guessing
                force_split = 1;
                special_scale_factor = 0.8;
              };
              master = {
                new_on_top = true;
                orientation = "left";
              };
              misc = {
                # Prevents apps from "stealing" focus when they open or request it
                focus_on_activate = false;
              };
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
                  "$mainMod SHIFT, R, exec, hyprctl reload"
                  # launch program menu
                  "SHIFTSUPER, P, exec, $menu"
                  "$mainMod, space, exec, ~/.config/hypr/scripts/emacs-launcher '(progn (select-frame-set-input-focus (selected-frame)) (universal-launcher-popup))'"
                  # "SHIFTSUPER, O, exec, grim -g '$(slurp)' ~/Pictures/screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png" # idk, flameshot doesn't work wihtout this
                  # "SHIFTSUPER, V, exec, cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"
                  "SHIFTSUPER, O, exec, flameshot gui --clipboard"

                  # scripts
                  # "$mainMod, f, exec, ${lib.getExe myScript}"
                  # volume control
                  # doesn't work
                  "$mainMod SHIFT, minus, exec, amixer -q sset Master 5%-"
                  "$mainMod CTRL, minus, exec, amixer -q sset Master 5%+"
                  # buffer manipulation
                  "$mainMod CTRL, F, fullscreen,"
                  "$mainMod CTRL, D, pseudo" # dwindle
                  # "$mainMod CTRL, S, togglesplit" # dwindle
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
                ", XF86AudioRaiseVolume, exec, pamixer -i 5"
                ", XF86AudioLowerVolume, exec, pamixer -d 5"
                ", XF86AudioMicMute, exec, pamixer --default-source -m"
                ", XF86AudioMute, exec, pamixer -t"
                ", XF86AudioPlay, exec, playerctl play-pause"
                ", XF86AudioPause, exec, playerctl play-pause"
                ", XF86AudioNext, exec, playerctl next"
                ", XF86AsudioPrev, exec, playerctl previous"
                # volume
                ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
                ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
              ];
              # hyprctl clients
              workspace = [
                "1, layoutopt:orientation:right"
              ];
              windowrule = [
                # Workspace rules (match:class is now required)
                "workspace 1, match:class ^(Emacs)$"
                "workspace 2, match:class ^(vivaldi-stable|firefox|[Bb]rave-browser)$"
                "workspace 3, match:class ^(discord|vesktop|Spotify|spotify|Proton Pass)$"
                "workspace 7, match:class ^(Proton Pass)$"
                "workspace 4, match:class ^([Ss]team|heroic)$"
                "workspace 5, match:class ^(SuperSlicer|OrcaSlicer)$"
                "workspace 6, match:class ^(transmission-gtk)$"

                # Steam rules (Note snake_case and values)
                "stay_focused 1, match:title ^()$, match:class ^(steam)$"
                "float 1, match:class ^([Ss]team)$, match:title ^((?![Ss]team).*)$"
                "workspace 4 silent, match:class ^([Ss]team)$, match:title ^([Ss]team)$"
                "tile 1, match:class ^([Ss]team)$, match:title ^([Ss]team)$"
                "no_focus 1, match:class ^([Ss]team)$, match:title ^((?![Ss]team).*)$"
                "no_blur 1, match:class ^([Ss]team)$"

                # Xwayland Bridge (Using snake_case and match prefix)
                "opacity 0.0 override 0.0 override, match:class ^(xwaylandvideobridge)$"
                "no_anim 1, match:class ^(xwaylandvideobridge)$"
                "no_focus 1, match:class ^(xwaylandvideobridge)$"
                "no_initial_focus 1, match:class ^(xwaylandvideobridge)$"

                # Fcitx (Fixed regex escaping and added values)
                "float 1, match:class ^(org\\.fcitx5\\..*)$"
                "pseudo 1, match:class ^(fcitx)$"
              ];
              exec-once = [
                "sleep 1 && waybar"
                "hyprpaper"
                "sleep 1 && ${pkgs.kitty}/bin/kitty"
                #"blueman-applet"
                "spotify"
                "vesktop"
                "vivaldi"
                "swaync"
                "flameshot"
                "fcitx5"
                "uwsm finalize"
              ];
            };
          };
        };
      };
  };
}
