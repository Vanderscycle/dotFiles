{ ... }:
{
  steppe.program._.cad = {
    cad =
      { pkgs, ... }:
      {
        programs.packages = with pkgs; [
          orca-slicer
          freecad
        ];
      };
  };
}
