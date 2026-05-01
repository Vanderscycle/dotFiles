{ ... }:
{
  steppe.program._.btop = {
    nixos = { };
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
