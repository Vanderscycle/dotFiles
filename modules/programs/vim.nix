{ inputs, ... }:
{
  steppe.program._.vim = {
    homeManager =
      { pkgs, ... }:
      {
        imports = [
          inputs.nixvim.homeModules.nixvim
        ];
        programs.nixvim = {
          enable = true;
          colorschemes.catppuccin.enable = true;
          plugins.lualine.enable = true;
        };
      };
  };
}
