{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    program.plastic_printer.superslicer.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables the SuperSlicer program for plastic_printer";
      default = false;
    };

    program.plastic_printer.orcaslicer.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables the OrcaSlicer program for plastic_printer";
      default = false;
    };

    program.plastic_printer.bambustudio.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables the Bambu Studio program for plastic_printer";
      default = false;
    };

    program.plastic_printer.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables 3D printing support";
      default = false;
    };
  };

  config = lib.mkIf config.program.plastic_printer.enable {
    home.packages =
      with pkgs;
      [ ]
      ++ (if config.program.plastic_printer.orcaslicer.enable then [ orca-slicer ] else [ ])
      ++ (if config.program.plastic_printer.superslicer.enable then [ super-slicer-beta ] else [ ])
      ++ (if config.program.plastic_printer.bambustudio.enable then [ bambu-studio ] else [ ]);
  };
}
