{ pkgs, ... }:
{
  # users.users."henri.vandersleyen" = {
  #   openssh.authorizedKeys.keysFiles = [
  #     # /Users/henri.vandersleyen/.ssh/knak
  #     /home/henri/.ssh/endeavour
  #   ];
  # };
  # allows for remote login of the machine.
  # TODO: create options that its not enabled  for work laptop
  programs.ssh = {
    enable = true;
  };
  home = {
    packages = with pkgs; [
      ssh-copy-id
    ];
  };
}
