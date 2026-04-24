{ ... }:
{
  steppe.program._.television = {
    homeManager =
      { pkgs, ... }:
      {
        programs.television = {
          enable = true;
          enableBashIntegration = true;
          enableZshIntegration = true;
          enableFishIntegration = true;
        };
      };
  };
}
