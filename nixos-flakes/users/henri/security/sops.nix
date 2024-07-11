{
  pkgs,
  inputs,
  config,
  username,
  ...
}:

{
  environment.systemPackages = [ pkgs.sops ];

  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age = {
      keyFile = "/home/${username}/.config/sops/age/keys.txt"; # TODO: how can I manage it between env?
      sshKeyPaths = [ "/home/${username}/.ssh/endeavourGit" ];
    };
    secrets = {
      # map them according to the file structure
      example-key = { };
      "myservice/my_subdir/my_secret" = { };
      "yubico/u2f_keys" = { };
    };
  };
}
