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
      enableZshIntegration = config.program.zsh.enable;
      enableFishIntegration = config.program.fish.enable;
    };
    catppuccin.television.enable = true;
  };
}
