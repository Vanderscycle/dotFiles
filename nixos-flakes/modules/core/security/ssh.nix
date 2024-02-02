{ username, pkgs, ... }:
{
  users.users.${username} = {
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMCpHZBybBTCsCyW6/Q4OZ07SvUpRUvclc10u25j0B+Q ${username}" ];
  };
  programs.ssh.startAgent = true;
  services.openssh = {
    enable = true;
  };
  environment.systemPackages = with pkgs;[
    ssh-copy-id
  ];
}
