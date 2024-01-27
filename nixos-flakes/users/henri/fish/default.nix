{ username, home-manager, pkgs, ... }:
{
  # fishPlugins.done
  # fishPlugins.fzf
  # fishPlugins.autopair
  # fishPlugins.z ? working?

  home-manager.users.${username} = {
    home = {
      sessionVariables = {
        # FCITX input-related
        GTK_IM_MODULE="fcitx";
        QT_IM_MODULE="fcitx";
        XMODIFIERS="@im=fcitx";
        GLFW_IM_MODULE="fcitx";
        INPUT_METHOD="fcitx";
        IMSETTINGS_MODULE="fcitx";

        SUDO_EDITOR = "emacs";
        EDITOR = "vim";
        BROWSER = "firefox";
        TERMINAL = "kitty";
        NNN_PLUG = "f:finder;o:fzopen;v:imgview;p:preview-tui;t:preview-tabbed";
        NNN_OPTS = "Hed";
        NNN_TMPFILE = "/tmp/nnn";
        NNN_FIFO = "/tmp/nnn.fifo";
        TLDR_AUTO_UPDATE_DISABLED = "false";
      };
    };
    programs.fish = {
      shellInit = ''
        set -x PATH $PATH $HOME/.npm-global/bin
      '';
      enable = true;
      plugins = with pkgs.fishPlugins; [
        {
          name = "done";
          src = done.src;
        }
        {
          name = "z";
          src = z.src;
        }
        {
          name = "autopair-fish";
          src = autopair-fish.src;
        }
        {
          name = "fzf-fish";
          src = fzf-fish.src;
        }
      ];
      #interactiveShellIinit = ''
      #'';
      functions = {
        envsource = ''
          for line in (cat $argv | grep -v '^#')
            set item (string split -m 1 '=' $line)
            set -gx $item[1] $item[2]
            echo "Exported key $item[1]"
          end
        '';
        screenshot = ''
          grim -g "$(slurp -d)" - | swappy -f -
        '';
        # Docker programs
        prusa-slicer = ''
          docker pull mikeah/prusaslicer-novnc:latest && docker run -v "/home/henri/Documents/3D-models:/data" -p 8080:8080 mikeah/prusaslicer-novnc:latest
        ''
        # ssh
        s-laptop = ''
          ssh henri@192.168.1.231
        ''
        # network
        kill-port = "kill -9 $(lsof -t -i:$argv)";
        # cloud access
        cloud-linode = "set -xg KUBECONFIG $HOME/.kube/infrastructure-kubeconfig.yaml";
        # docker
        docker-crmAll = "docker rm -f (docker ps -aq)";
        docker-irmAll = "docker rmi -f (docker images  -aq)";
        docker-vrmAll = "docker volume prune";
        docker-prmAll = "docker builder prune -af";
        # kubernetes
        k-seal = ''
          kubectl -n "$argv[1]" get secret "$argv[2]" -o json | jq '.data | map_values(@base64d)'
        '';
        k8s-prmAll = "kubectl delete all --all --namespaces";
        k8s-prmNamespace = ''
          kubectl delete all --all -n "$argv[1]"
        '';
        # nix
        nixit =  ''
          set -xg SHELL_FILE (find /home/henri/Documents/houseOfNixAndPain/shells -name 'shell.nix' | fzf)
          nix-shell $SHELL_FILE 
        '';
        nix-clean = "nix-store --gc";
        nix-update="sudo nixos-rebuild switch";
        nix-purge = ''
          sudo nix-collect-garbage -d
          sudo nix-store --optimise
          sudo nix-env --delete-generations old 
          sudo nix-env --delete-generations old --profile /nix/var/nix/profiles/system
        '';
        # editor
        hx-sudo = "sudo hx --config $HOME/.config/helix/config.toml";
        # nnn
        n = ''
          nnn
          if test -e $NNN_TMPFILE
                  source $NNN_TMPFILE
                  rm -rf $NNN_TMPFILE
          end
        '';
        # dotFiles
        save = ''
          bash $HOME/Documents/dotFiles/postInstallScripts/nixos/save.sh
        '';
        # git
        gSquash = ''
          git reset (git merge-base "$argv" (git branch --show-current))
        '';
        # bios
        bios = "systemctl reboot --firmware-setup";
        # usb
        usb-mount = "sudo mount /dev/sda1 /mnt/usb";
        usb-eject = "sudo umount /mnt/usb";
        nas-mount = "sudo mount.nfs 192.168.1.245:/volume1/linuxBackup /mnt/nas"; # how to allow users acces to the file?
        nas-eject = "sudo umount /mnt/nas";
        # kitty
        new_kitty_tab = "kitty @ new-tab --cwd (pwd)";
        };
      shellAbbrs = {
        l = "less";
        k = "kustomize";
      };
      shellAliases = {
        "..." = "cd ../..";
        ls = "eza -al";
        ":q" = "exit";
        top = "btop";
        kt="new_kitty_tab";
      };
    };
  };
}
