{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    program.office.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables libreoffice";
      default = false;
    };
  };

  config = lib.mkIf config.program.office.enable {
    home.packages = with pkgs; [
      libreoffice-qt
      hunspell
      xournalpp # allows for pdf form filling
      hunspellDicts.en_CA
      hunspellDicts.en_US
    ];
  };
}
