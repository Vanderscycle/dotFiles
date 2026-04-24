{ ... }:
{
  steppe.program._.broot = {
    homeManager =
      { pkgs, ... }:
      {
        programs.broot = {
          enable = true;
          enableNushellIntegration = true;
          enableBashIntegration = true;
          enableZshIntegration = true;
          enableFishIntegration = true;
        };
      };
  };
}
