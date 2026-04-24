{ ... }:
{
  steppe.program._.fuzzel = {
    includes = [
    ];
    nixos = { };
    homeManager = {
      programs = {
        fuzzel = {
          enable = true;
        };
      };
    };
  };
}
