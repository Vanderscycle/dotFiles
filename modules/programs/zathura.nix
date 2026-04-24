{ inputs, ... }:
{
  steppe.program._.zathura = {
    homeManager =
      { pkgs, ... }:
      {
        programs = {
          zathura = {
            enable = true;
          };
        };
      };
  };
}
