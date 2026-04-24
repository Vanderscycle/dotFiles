{
  config,
  inputs,
  ...
}:
let
  sops_config = {
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/var/lib/secrets/sops/age/subutai.txt";
    # ssh.privateKeyFile = "/home/henri/.ssh/temujin";
  };
in
{
  den.aspects.ilkhan = {
    includes = [ ];
    nixos = {
      imports = [ inputs.sops-nix.nixosModules.sops ];
      sops = sops_config;
    };
    homeManager =
      { pkgs, ... }:
      {
        imports = [ inputs.sops-nix.homeManagerModules.sops ];
        sops = sops_config;
        home.sessionVariables = {
          "SOPS_AGE_KEY_FILE" = sops_config.age.keyFile;
          # "SOPS_AGE_SSH_PRIVATE_KEY_FILE" = sops_config.ssh.privateKeyFile;
        };
        home.packages = [ pkgs.sops ];
      };
  };
}
