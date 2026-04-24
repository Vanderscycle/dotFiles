{ ... }:
{
  steppe.program._.spotify = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          spotify
        ];
      };
  };
}
