{ themes, username, ... }:

{
  home-manager.users.${username} = {
    home = { };
    programs = {
      zathura = {
        enable = true;
        catppuccin.enable = true;
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
  };
}
