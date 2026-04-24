{ ... }:
{
  steppe.program._.lazygit = {
    homeManager =
      { pkgs, ... }:
      {
        programs.lazygit = {
          enable = true;
          enableBashIntegration = true;
          enableZshIntegration = true;
          enableFishIntegration = true;
          enableNushellIntegration = true;
        };
      };
  };
}
