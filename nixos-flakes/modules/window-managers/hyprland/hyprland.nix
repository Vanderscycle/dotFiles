{
  username,
  home-manager,
  inputs,
  pkgs,
  system,
  lib,
  ...
}:
{
  programs = {
    hyprland = {
      enable = true;
      # package = pkgs.hyprland.overrideAttrs {
      #   src = pkgs.fetchFromGitHub {
      #     owner = "hyprwm";
      #     repo = "Hyprland";
      #     fetchSubmodules = true;
      #     rev = "9e781040d9067c2711ec2e9f5b47b76ef70762b3"; # "v0.41.1";
      #     hash = "sha256-pYWlT7CB8F5h8Cuydsq4pKu7dKRYb1BVTq+HJfmLsoo=";
      #   };
      # };
      xwayland = {
        enable = true;
      };
    };
  };
  environment.variables = {
    MOZ_ENABLE_WAYLAND = "1"; # For Firefox, similar for other apps
    NIXOS_OZONE_WL = "1";
    GDK_BACKEND = "wayland";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
  services = {
    displayManager = {
      autoLogin = {
        enable = true;
        user = "${username}";
      };
    };
    xserver = {
      enable = true;
      displayManager = {
        gdm = {
          enable = true;
          wayland = true;
        };
      };
    };
  };

  home-manager.users.${username} = {
    home = {
      packages = with pkgs; [
        swww
        wl-clipboard
        hyprcursor
        flameshot
      ];
    };
    wayland.windowManager = {
      hyprland = {
        catppuccin.enable = true;
        enable = true; # allow home-manager to configure hyprland
        settings = {
          input = {
            kb_layout = "us";
            # focus change on cursor move
            follow_mouse = 0;
            accel_profile = "flat";
          };
          general = {
            gaps_in = 7;
            gaps_out = 20;
            border_size = 2;
            layout = "dwindle";
          };
          decoration = {
            blur = {
              enabled = true;
              size = 8;
              passes = 1;
              new_optimizations = true;
            };
            rounding = 10;
            # drop_shadow = "yes";
            # shadow_range = 2;
            # shadow_render_power = 2;
            # col.shadow = "rgb (21 ce07)";
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
            # animation = [
            #   "windows = 1, 7, myBezier"
            #   "windowsOut = 1, 7, default, popin 80%"
            #   "border = 1, 10, default"
            #   "borderangle = 1, 8, default"
            #   "fade = 1, 7, default"
            #   "workspaces = 1, 6, default"
            # ];
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
          "$mainMod" = "SUPER";
          # https://wiki.hyprland.org/Configuring/Keywords/
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
              # move window
              "$mainMod ALT, H, movewindow, l"
              "$mainMod ALT, L, movewindow, r"
              "$mainMod ALT, K, movewindow, u"
              "$mainMod ALT, J, movewindow, d"
              # resize window
              "$mainMod SHIFT, h, resizeactive, -40 0"
              "$mainMod SHIFT, l, resizeactive, 40 0"
              "$mainMod SHIFT, k, resizeactive, 0 -40"
              "$mainMod SHIFT, j, resizeactive, 0 40"
              # launch program menu
              "SHIFTSUPER, P, exec, fuzzel --background-color=1e1e2eff --text-color=cdd6f4ff --border-color=cba6f7ff"
              "SHIFTSUPER, O, exec, flameshot gui --clipboard"
              # dedicated programs
              "$mainMod SHIFT, T, exec, thunar"
              "$mainMod, Q, exec, kitty"
              # scripts
              "$mainMod, f, exec, ${lib.getExe myScript}"
              # volume control
              "$mainMod SHIFT, minus, exec, amixer -q sset Master 5%-"
              "$mainMod CTRL, minus, exec, amixer -q sset Master 5%+"
              # buffer manipulation
              "$mainMod SHIFT, F, fullscreen,"
              "$mainMod, D, pseudo"
              "$mainMod, S, togglesplit"
              #"$mainMod SHIFT, E, exec, pkill fcitx5 -9;sleep 1;fcitx5 -d --replace; sleep 1;fcitx5-remote -r"
              "$mainMod, C, killactive,"
              "$mainMod, V, togglefloating,"
              # Workplace movement
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
              # Workplace buffer changes
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
            # "$mainMod, L, movewindow"
            # "$mainMod, K, resizewindow"
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
          windowrule = [
            "workspace 1, Emacs"
            "workspace 2, firefox"
            "workspace 3, discord"
            "workspace 3, Spotify"
            "workspace 3, spotify"
            "workspace 3, Slack"
            "workspace 4, steam"
            "workspace 4, Steam"
            "workspace 5, SuperSlicer"
            "workspace 5, OrcaSlicer"
            "workspace 6, Transmission"
            "pseudo,fcitx"
          ];

          windowrulev2 = [
            # steam
            "float, class:^([Ss]team)$, title:^((?![Ss]team).*)$"
            "workspace 4 silent, class:^([Ss]team)$, title:^([Ss]team)$"
            "tile, class:^([Ss]team)$, title:^([Ss]team)$"
            "workspace 4 silent, class:^([Ss]team)$ title:^(notificationtoasts_.*)$"
            # orcaslicer
            # https://github.com/hyprwm/Hyprland/issues/6698
            "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
            "noanim,class:^(xwaylandvideobridge)$"
            "nofocus,class:^(xwaylandvideobridge)$"
            "noinitialfocus,class:^(xwaylandvideobridge)$"
            "float, class:^(org.fcitx5.)$"
          ];
          exec-once = [
            "swww img ~/Pictures/switch.png"
            "waybar"
            "dunst"
            "discord --enable-wayland-ime"
            "spotify"
            "firefox"
            "kitty"
            "flameshot"
            # "emacs" # TODO: make it spawn out of a shell
          ];
        };
      };
    };
  };
}
