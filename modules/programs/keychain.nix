{ ... }:
{
  steppe.program._.keychain = {
    nixos = {
      programs.ssh.startAgent = false;
    };
    homeManager =
      { config, pkgs, ... }:
      {
        programs = {
          keychain = {
            enable = true;
            enableFishIntegration = true;
            enableZshIntegration = true;
            enableNushellIntegration = true;
            enableBashIntegration = true;
            # extraFlags = [
            #   "--agents"
            #   "ssh"
            # ];
            keys = [
              "${config.home.homeDirectory}/.ssh/endeavourGit"
              "${config.home.homeDirectory}/.ssh/temujin"
              "${config.home.homeDirectory}/.ssh/gitea"
            ];
          };
        };
      };
  };
}
