{ themes
, username,
  ...
}:


{
  home-manager.users.${username} = {
    programs = {
      zathura = {
        enable = true;
        options = {
          font =  "JetBrainsMono 10";
          # notification-error-bg = themes.base03;
          # notification-error-fg = themes.base01;
          # notification-warning-bg = themes.base05;
          # notification-warning-fg = themes.base02;
          # notification-bg = themes.base00;
          # notification-fg = themes.base02;
          # completion-bg = themes.base00;
          # completion-fg = themes.base09;
          # completion-group-bg = themes.base00;
          # completion-group-fg = themes.base09;
          # completion-highlight-bg = themes.base02;
          # completion-highlight-fg = themes.base01;
          # index-bg = themes.base00;
          # index-fg = themes.base01;
          # index-active-bg = themes.base02;
          # index-active-fg = themes.base01;
          # inputbar-bg = themes.base00;
          # inputbar-fg = themes.base01;
          # statusbar-bg = themes.base00;
          # statusbar-fg = themes.base01;
          # highlight-color = themes.base06;
          # highlight-active-color = themes.base07;
          # default-bg = themes.base00;
          # default-fg = themes.base01;
          render-loading = true;
          # render-loading-fg = themes.base00;
          # render-loading-bg = themes.base01;
          # recolor-lightcolor = themes.base00;
          # recolor-darkcolor = themes.base01;
          adjust-open = "width";
          recolor = true;
          guioptions = "s";
          smooth-scroll = "true";
          statusbar-home-tilde = "true";
          incremental-search = "true";
        };
        mappings = {
          "<Right>" = "navigate next";
          "D" = "toggle_page_mode";
          "<C-Tab>" =  "toggle_statusbar";
        };
      };
    };
  };
}
