{ ... }:
{
  steppe.program._.atuin = {
    homeManager = {
      programs.atuin = {
        enable = true;
        flags = [ "--disable-up-arrow" ];
        enableFishIntegration = true;
        enableZshIntegration = true;
        enableNushellIntegration = true;
        enableBashIntegration = true;
      };
    };
  };
}
