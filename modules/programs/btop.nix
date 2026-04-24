{ ... }:
{
  steppe.program._.btop = {
    homeManager =
      { pkgs, ... }:
      {
        programs.btop = {
          enable = true;
          settings = {
            theme_background = true;
          };
        };
      };
  };
}
