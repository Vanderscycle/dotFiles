{ pkgs, hostname, ... }:
{

  users = {
    mutableUsers = false;
    users."${hostname}" = {
      isNormalUser = true;
      password = "root";
      shell = pkgs.fish;
      extraGroups = [ "wheel" ];
      # openssh.authorizedKeys.keys = [
      #   "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMCpHZBybBTCsCyW6/Q4OZ07SvUpRUvclc10u25j0B+Q ${hostname}"
      # ];
    };
  };
}
