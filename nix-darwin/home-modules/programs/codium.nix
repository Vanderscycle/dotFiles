{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    program.codium.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables the open source vscode";
      default = false;
    };
  };

  # common issue on MacOs when getting ="Creating pipe" "too many open files"=
  # https://gist.github.com/tombigel/d503800a282fcadbee14b537735d202c
  config = lib.mkIf config.program.codium.enable {
    home = {
      packages = with pkgs; [
        vscodium
      ];
    };
  };
}
