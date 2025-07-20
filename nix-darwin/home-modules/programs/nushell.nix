{
  lib,
  config,
  ...
}:
{
  options = {
    program.nushell.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables nushell";
      default = true;
    };
  };

  config = lib.mkIf config.program.nushell.enable {
    programs.nushell = {
      enable = true;
      environmentVariables = {
        ENTERPRISE_REPO_PATH = "~/knak";
      };
      configFile.text = ''
        let catppuccin = {
          mocha: {
            rosewater: "#f5e0dc"
            flamingo: "#f2cdcd"
            pink: "#f5c2e7"
            mauve: "#cba6f7"
            red: "#f38ba8"
            maroon: "#eba0ac"
            peach: "#fab387"
            yellow: "#f9e2af"
            green: "#a6e3a1"
            teal: "#94e2d5"
            sky: "#89dceb"
            sapphire: "#74c7ec"
            blue: "#89b4fa"
            lavender: "#b4befe"
            text: "#cdd6f4"
            subtext1: "#bac2de"
            subtext0: "#a6adc8"
            overlay2: "#9399b2"
            overlay1: "#7f849c"
            overlay0: "#6c7086"
            surface2: "#585b70"
            surface1: "#45475a"
            surface0: "#313244"
            base: "#1e1e2e"
            mantle: "#181825"
            crust: "#11111b"
          }
        }
        let stheme = $catppuccin.mocha
        let theme = {
          separator: $stheme.overlay0
          leading_trailing_space_bg: $stheme.overlay0
          header: $stheme.green
          date: $stheme.mauve
          filesize: $stheme.blue
          row_index: $stheme.pink
          bool: $stheme.peach
          int: $stheme.peach
          duration: $stheme.peach
          range: $stheme.peach
          float: $stheme.peach
          string: $stheme.green
          nothing: $stheme.peach
          binary: $stheme.peach
          cellpath: $stheme.peach
          hints: dark_gray

              }
              let $config = {
                 shell_integration: true
                 table_mode: rounded
          color_config: $theme
          cursor_shape: {
            vi_normal: block
            vi_insert: line
          }
          edit_mode: vi
          keybindings: [
            {
              name: completion_menu
              modifier: none
              keycode: tab
              mode: [emacs vi_normal vi_insert]
              event: {
                until: [
                  { send: menu name: completion_menu }
                  { send: menunext }
                ]
              }
            }
            {
              name: completion_previous
              modifier: shift
              keycode: backtab
              mode: [emacs, vi_normal, vi_insert] # Note: You can add the same keybinding to all modes by using a list
              event: { send: menuprevious }
            }
            {
              name: jump_to_start
              keycode: char_h
              modifier: shift
              mode: [vi_normal]
              event: { edit: MoveToLineStart }
            }
            {
              name: jump_to_end
              modifier: shift
              keycode: char_l
              mode: [vi_normal]
              event: { edit: MoveToLineEnd }
            }
          ]
            completions: {
            algorithm: "fuzzy",
          }
                 }
      '';
      shellAliases = {
        ".." = "cd ..";
        "..." = "cd ../..";
      };
    };
  };
}
#https://github.com/tesujimath/bash-env-nushell?tab=readme-ov-file
#there a nix flake that would support this
# loginFile = ''
#   if [[ -f $ENTERPRISE_REPO_PATH/scripts/mfa-token-loader.sh ]]; then source $ENTERPRISE_REPO_PATH/scripts/mfa-token-loader.sh; fi
#   [[ -f $ENTERPRISE_REPO_PATH/scripts/aliases ]] && source $ENTERPRISE_REPO_PATH/scripts/aliases
# '';
