{
  username,
  home-manager,
  config,
  pkgs,
  ...
}:
{

  home-manager.users.${username} = {
    home = { };
    xdg.configFile."lf/icons".source = ./icons;

    programs.lf = {
      enable = true;
      commands = {
        mkdir = ''
          ''${{
            printf "Directory Name: "
            read DIR
            mkdir $DIR
          }}
        '';
        editor-open = ''
          nvim $f
        '';
        touch = ''
          ''${{
            printf "File Name: "
            read FILE
            touch $FILE
          }}
        '';
      };

      keybindings = {
        cd = "mkdir";
        cf = "touch";
        d = "delete";
        "." = "set hidden!";
        "<enter>" = "open";

        "g~" = "cd";
        gh = "cd";
        "g/" = "/";

        e = "editor-open";
        V = ''
          bat --paging=always "$f"
        '';

        # ...
      };

      settings = {
        preview = true;
        hidden = true;
        drawbox = true;
        icons = true;
        ignorecase = true;
      };

      extraConfig =
        let
          # https://github.com/gokcehan/lf/wiki/Previews#with-kitty-and-pistol
          previewer = pkgs.writeShellScriptBin "pv.sh" ''
            file=$1
            w=$2
            h=$3
            x=$4
            y=$5

            if [[ "$( ${pkgs.file}/bin/file -Lb --mime-type "$file")" =~ ^image ]]; then
                ${pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
                exit 1
            fi

            ${pkgs.pistol}/bin/pistol "$file"
          '';
          cleaner = pkgs.writeShellScriptBin "clean.sh" ''
            ${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
          '';
        in
        ''
          set cleaner ${cleaner}/bin/clean.sh
          set previewer ${previewer}/bin/pv.sh
        '';
    };

    programs.fish.functions = {
      lfcd = ''
        cd "$(command lf -print-last-dir $argv)"
      '';
    };
  };
}
