{ ... }:
{
  steppe.program._.nushell = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.nushell ];
      };
    homeManager =
      { pkgs, ... }:
      {
        # https://discourse.nixos.org/t/nushell-broken-in-nix-develop/76402/2
        xdg.configFile.dashrc.text = ''
          if ! [ "$TERM" = "dumb" ]; then
              # Disable C-s freezing the terminal
              stty -ixon
              exec nu
            fi
        '';
        programs = {
          bash.profileExtra = ''
            export ENV="$HOME/.config/dashrc"
          '';
          nushell = {
            enable = true;
            package = pkgs.nushell.override {
              additionalFeatures = _: [
                "full"
                "mcp"
              ];
            };
            plugins = with pkgs.nushellPlugins; [
              # highlight
              # query
              # skim
            ];
            shellAliases = {
              o = "xdg-open";
            };
            extraConfig = ''
              $env.config = {
                show_banner: false
                rm: {
                  always_trash: true
                }
                display_errors: {
                    exit_code: false
                    termination_signal: true
                }
                completions: {
                  algorithm: "substring"
                }
              }

              $env.config.keybindings ++= [
                {
                  name: deleteword
                  modifier: control
                  keycode: backspace
                  mode: [ emacs vi_normal vi_insert ]
                  event: { edit: BackspaceWord }
                }
              ]
              if "INSIDE_EMACS" in $env {
                $env.EDITOR = "emacsclient -r"
                $env.VISUAL = "emacsclient -r"
              }
            '';
          };
        };
        xdg.configFile = {
          "nushell/autoload/nxs.nu".text = ''
            # zoxide poorly handles trailing /
            def cd --env --wrapped (...rest: string) {
            let trimmed = if ($rest | is-empty) ({
                $rest
                }) else {
                $rest | update ($rest | length | $in - 1) { str trim -r -c '/' }
            }
              __zoxide_z ...$trimmed
            }

            # faster nix shell command when needing many packages
            def --wrapped nxs (...input: string) {
              let flags = $input | where ($it | str starts-with "-")
              let packages = $input | where not ($it | str starts-with "-")
              let formatted_packages = $packages | each {|package|
                if not ($package | str contains "#") {
                  return $"nixpkgs#($package)"
                }
                $package
              }
              ^nix shell ...$formatted_packages ...$flags
            }
          '';
        };
      };
  };
}
