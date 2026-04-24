{ ... }:
{
  steppe.program._.beekeeper = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [ beekeeper-studio ];
      };
  };
}
