{
  lib,
  config,
  ...
}:
{
  options = {
    program.television.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables television";
      default = false;
    };
  };

  config = lib.mkIf config.program.television.enable {
    programs.television = {
      enable = true;
      #INFO: cross reference for other config options
      enableZshIntegration = lib.mkIf config.program.zsh.enable true;
      enableFishIntegration = lib.mkIf config.program.zsh.enable true;
    };
    catppuccin.television.enable = true;
  };
}
