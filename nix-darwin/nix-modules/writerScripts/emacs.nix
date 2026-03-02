{
  pkgs ? import <nixpkgs> { },
  config,
  lib,
  ...
}:
let
  emacs-env = pkgs.writeShellScriptBin "update-spacemacs-env" ''
    # Delete the last line of the file
    sed -i '$ d' ~/.spacemacs.d/.spacemacs.env
    echo "SSH_AUTH_SOCK=$SSH_AUTH_SOCK" >> ~/.spacemacs.d/.spacemacs.env
    ${pkgs.emacs}/bin/emacsclient -e "(dotspacemacs/call-user-env)" || true
  '';
in
{
  options.script.emacs = {
    enable = lib.mkOption {
      type = lib.types.bool;
      description = "Adds bash scripts pertaining to emacs";
      default = false;
    };
    runAtStartup = lib.mkOption {
      type = lib.types.bool;
      description = "Automatically update Spacemacs env on login/startup";
      default = false;
    };
  };

  config = lib.mkMerge [
    # Install the script if either option is enabled
    (lib.mkIf (config.script.emacs.enable || config.script.emacs.runAtStartup) {
      environment.systemPackages = [ emacs-env ];
    })

    # Enable the systemd user service only if runAtStartup is true
    (lib.mkIf config.script.emacs.runAtStartup {
      systemd.user.services.spacemacs-env-update = {
        description = "updates spacemacs ssh_auth_sock at start";
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = false;
          # Ensures the script has access to the user environment
          PassEnvironment = [
            "SSH_AUTH_SOCK"
            "DISPLAY"
            "XAUTHORITY"
          ];
        };
        script = "${emacs-env}/bin/update-spacemacs-env";
        wantedBy = [ "default.target" ];
      };
    })
  ];
}
