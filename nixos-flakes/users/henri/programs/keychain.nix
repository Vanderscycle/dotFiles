{ username, home-manager, pkgs, ... }:
{
  home-manager.users.${username} = {
    programs.keychain = {
      enable = true;
      enableFishIntegration = true;
      keys = [ "$HOME/.ssh/endeavourGit" ];
    };
  };
}
