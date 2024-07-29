{
  username,
  home-manager,
  pkgs,
  ...
}:
{
  home-manager.users.${username} = {
    programs = {
      nnn = {
        enable = true;
        package = pkgs.nnn.override ({ withNerdIcons = true; });
        plugins.mappings = {
          f = "finder";
          o = "fzopen";
          p = "preview-tui";
          t = "preview-tabbed";
        };
        bookmarks = {
          d = "/home/${username}/Documents";
          D = "/home/${username}/Downloads";
          P = "/home/${username}/Programs";
          m = "/mnt/";
        };
      };
    };
    home = {
      sessionVariables = {
        # NNN_PLUG = "f:finder;o:fzopen;p:preview-tui;t:preview-tabbed"; # tabbed is x only
        NNN_OPTS = "Hedac";
        NNN_TMPFILE = "/tmp/nnn";
        NNN_FIFO = "/tmp/nnn.fifo";
        SPLIT = "v";
        LC_COLLATE = "C";
      };
    };

    programs.fish.functions = {
      n = ''
        nnn -P p
        if test -e $NNN_TMPFILE
                source $NNN_TMPFILE
                rm -rf $NNN_TMPFILE
        end
      '';
    };
  };
}
