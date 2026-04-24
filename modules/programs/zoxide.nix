{ ... }:
{
  steppe.program._.zoxide = {
    homeManager =
      { pkgs, ... }:
      {
        programs.zoxide = {
          enable = true;
        };
      };
  };
}
