{ ... }:
{
  steppe.program._.carapace = {
    homeManager =
      { pkgs, ... }:
      {
        programs.carapace = {
          enable = true;
          enableNushellIntegration = true;
          enableFishIntegration = true;
          enableBashIntegration = true;
          enableZshIntegration = true;
        };
      };
  };
}
