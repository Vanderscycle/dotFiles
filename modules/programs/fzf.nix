{ ... }:
{
  steppe.program._.fzf = {
    homeManager =
      { pkgs, ... }:
      {
        programs.fzf = {
          enable = true;
          enableBashIntegration = true;
          enableFishIntegration = true;
          enableZshIntegration = true;
        };
      };
  };
}
