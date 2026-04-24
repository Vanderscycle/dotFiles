{ ... }:
{
  steppe.program._.keychain = {
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
            keys = [
              "${config.home.homeDirectory}/.ssh/endeavourGit"
              "${config.home.homeDirectory}/.ssh/temujin"
            ];
          };
        };
      };
  };
}
