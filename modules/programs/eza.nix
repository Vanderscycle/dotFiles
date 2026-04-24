{ ... }:
{
  steppe.program._.eza = {
    homeManager =
      { pkgs, ... }:
      {
        programs.eza = {
          enable = true;
          git = true;
          icons = "auto";
          enableNushellIntegration = true;
          enableBashIntegration = true;
          enableZshIntegration = true;
          enableFishIntegration = true;
        };
      };
  };
}
