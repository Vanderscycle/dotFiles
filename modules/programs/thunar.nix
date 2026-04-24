{ ... }:
{
  steppe.program._.thunar = {
    nixos = {
      programs.thunar = {
        enable = true;
        plugins = [ ];
      };
    };
    homeManager = {
    };
  };
}
