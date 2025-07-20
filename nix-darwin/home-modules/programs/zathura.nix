{
  lib,
  config,
  ...
}:
{
  options = {
    program.zathura.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables zathura pdf viewer";
      default = false;
    };
  };

  config = lib.mkIf config.program.zathura.enable {

    programs = {
      zathura = {
        enable = true;
        options = {
          font = "JetBrainsMono 14";
          render-loading = true;
          adjust-open = "width";
          guioptions = "s";
          smooth-scroll = "true";
          statusbar-home-tilde = "true";
          incremental-search = "true";
          selection-clipboard = "clipboard";
        };
        mappings = {
          "<Right>" = "navigate next";
          "D" = "toggle_page_mode";
          "<C-Tab>" = "toggle_statusbar";
        };
      };
    };
    catppuccin.zathura.enable = true;
  };
}
