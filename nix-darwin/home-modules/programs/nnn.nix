{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    program.nnn.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables comfier nnn file navigator";
      default = true;
    };
  };

  config = lib.mkIf config.program.nnn.enable {
    # within $home/.config/nnn/plugins
    # sh -c "$(curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs)"
    programs = {
      nnn = {
        enable = true;
        package = pkgs.nnn.override ({ withNerdIcons = true; });
        plugins.mappings = {
          z = "autojump";
          d = "dragdrop";
          f = "finder";
          o = "fzopen";
          p = "preview-tui";
          c = "fzcd";
          m = "mimelist";
        };
        bookmarks = {
          d = "~/Documents";
          P = "~/Documents/pdfs";
          k = "~/Documents/3d-printing";
          D = "~/Downloads";
          v = "~/Videos";
          p = "~/Pictures";
          m = "/mnt/";
        };
      };
    };
    home = {
      packages = with pkgs; [ xdragon ];
      sessionVariables = {
        # NNN_PLUG = "f:finder;o:fzopen;p:preview-tui;t:preview-tabbed"; # tabbed is x only
        NNN_OPTS = "Hedac";
        NNN_TMPFILE = "/tmp/nnn";
        NNN_FIFO = "/tmp/nnn.fifo";
        SPLIT = "v";
        LC_COLLATE = "C";
      };
    };

    programs = {
      autojump = {
        enable = true;
      };
      fish = {
        shellAliases = {
          z = "j";
        };
        functions = {
          n = ''
            nnn -P p
            if test -e $NNN_TMPFILE
                    source $NNN_TMPFILE
                    rm -rf $NNN_TMPFILE
            end
          '';
        };
      };
      zsh = {
        shellAliases = {
          z = "j";
          n = "nnn -P p && if [[ -e $NNN_TMPFILE ]]; then source $NNN_TMPFILE; rm -rf $NNN_TMPFILE; fi";
        };
      };

      nushell = {
        shellAliases = {
          n = "nnn -P p";
          z = "j";
        };
      };
    };
  };
}
