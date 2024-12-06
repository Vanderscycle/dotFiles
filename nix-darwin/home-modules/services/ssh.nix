{ pkgs, ... }:
{
  users.users."henri.vandersleyen" = {
    openssh.authorizedKeys.keysFiles = [
      /Users/henri.vandersleyen/.ssh/knak
    ];
  };
  # allows for remote login of the machine.
  # TODO: create options that its not enabled  for work laptop
  services.openssh = {
    enable = false;
  };

  home = {

    programs.ssh = {
      enable = true;
    };
    packages = with pkgs; [
      ssh-copy-id
    ];
  };
}
