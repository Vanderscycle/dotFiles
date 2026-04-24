{
  ...
}:
{
  steppe.program._.yubico = {
    nixos =
      { config, pkgs, ... }:
      {
        sops.secrets."yubico/temujin/u2f_keys" = { };
        sops.secrets."yubico/temujin/keyID" = { };
        security = {
          pam = {
            sshAgentAuth.enable = true;
            u2f = {
              enable = true;
              settings = {
                cue = true; # tell users to push button
                authFile = config.sops.secrets."yubico/temujin/u2f_keys".path;
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
              mode = "challenge-response";
              id = config.sops.secrets."yubico/temujin/keyID".path;
            };
          };
        };
        services = {
          udev.packages = [ pkgs.yubikey-personalization ];
          pcscd.enable = true;
          yubikey-agent.enable = true;
        };
      };
    homeManager = {
    };
  };
}
