{
  pkgs,
  lib,
  config,
  ...
}:
let
  name = "henri";
  homeDirectory = if pkgs.stdenv.isLinux then "/home/${name}" else "/Users/${name}";
in
{
  options = {
    yubico.enable = lib.mkOption {
      type = lib.types.bool;
      description = "enables yubico key 2mfa";
      default = false;
    };
    yubico.keyID = lib.mkOption {
      type = lib.types.str;
      description = "enables the key";
      default = false;
    };
  };

  # https://nixos.wiki/wiki/Yubikey
  config = lib.mkIf config.yubico.enable {
    security = {
      pam = {
        sshAgentAuth.enable = true;
        u2f = {
          enable = true;
          settings = {
            cue = true; # tell users to push button
            authFile = config.sops.secrets."yubico/u2f_keys".path;
          };
        };
        services = {
          login.u2fAuth = false;
          sudo.u2fAuth = true;
          sudo.sshAgentAuth = true;
        };
        yubico = {
          enable = true;
          debug = true;
          # mode = "challenge-response";
          id = config.yubico.keyID;
        };
      };
    };
    services.udev.packages = [ pkgs.yubikey-personalization ];
    services.pcscd.enable = true;
    services.yubikey-agent.enable = true;
    environment.systemPackages = with pkgs; [
      pcsclite
      yubikey-manager # ykman
      ccid
      # pam_2uf
    ];
  };
}
