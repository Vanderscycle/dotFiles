{
  inputs,
  username,
  config,
  ...
}:
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];
  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age.keyFile = "/Users/${username}/.config/sops/age/keys.txt";
    secrets = {
      "knak/email" = {
        # owner = username;
      };
      "knak/git/userName" = {
        # owner = username;
      };
      "knak/git/keyName" = {
        # owner = username;
      };
    };
  };

}
