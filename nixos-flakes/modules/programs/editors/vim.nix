{
  home-manager,
  username,
  pkgs,
  inputs,
  ...
}:
{
  home-manager.users.${username} = {
    imports = [ inputs.nixvim.homeManagerModules.nixvim ];
    programs.nixvim = {
      enable = true;
      colorschemes.catppuccin.enable = true;
      plugins = {
        telescope = {
          enable = true;
        };
        lightline.enable = true;
        # git
        lazygit.enable = true;
        # languages
        lsp = {
          enable = true;

          servers = {
            tsserver.enable = true;

            lua-ls = {
              enable = true;
              settings.telemetry.enable = false;
            };
            rust-analyzer = {
              enable = true;
              installCargo = true;
            };
          };
        };
      };
    };
  };
}
