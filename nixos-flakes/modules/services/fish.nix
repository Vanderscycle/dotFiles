{
  username,
  home-manager,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs.fishPlugins; [
    fzf-fish # configure https://github.com/PatrickF1/fzf.fish
    z
    autopair
    done
  ];
  home-manager.users.${username} = {
    home = {
      sessionVariables = {
        SUDO_EDITOR = "nvim";
        EDITOR = "nvim";
        # SUDO_EDITOR = "emacsclient";
        # EDITOR = "emacsclient";
        BROWSER = "firefox";
        TERMINAL = "kitty";
        TLDR_AUTO_UPDATE_DISABLED = "false";
      };
    };
    programs.fish = {
      enable = true;
      catppuccin.enable = true;
      shellInit = ''
        set -x PATH $PATH $HOME/.npm-global/bin
      '';
      interactiveShellInit = ''
        keychain --eval --agents ssh endeavourGit

      '';
      functions = {
        clear-trash = ''
          rm -rf ~/.local/share/Trash/*
        '';
        copy = ''
          set selected_file (fzf)
          if test -z "$selected_file"
                  echo "No file selected."
                  return 1
              end

          cat "$selected_file" | wl-copy
          echo "Contents of $selected_file copied to clipboard."
        '';
        envsource = ''
          for line in (cat $argv | grep -v '^#')
            set item (string split -m 1 '=' $line)
            set -gx $item[1] $item[2]
            echo "Exported key $item[1]"
          end
        '';
        screenshot = ''
          grim -g "$(slurp -o -r -c '#ff0000ff')" - | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png
        '';
        # ssh
        s-laptop = ''
          ssh henri@192.168.1.231
        '';
        s-nas = ''
          ssh sysAdminHarambe@192.168.1.246
        '';
        s-router = ''
          ssh root@192.168.1.1
        '';
        v-minion-save = ''
          rsync -avz pi@192.168.1.243:/home/pi/printer_data/config/custom pi@192.168.1.243:/home/pi/printer_data/config/printer.cfg /home/${username}/Documents/3D-models/printer_configs/v-minion/
        '';
        # network
        kill-port = "kill -9 $(lsof -t -i:$argv[1])";
        # cloud access
        cloud-linode = "set -xg KUBECONFIG $HOME/.kube/infrastructure-kubeconfig.yaml";
        # docker
        docker-crmAll = "docker rm -f (docker ps -aq)";
        docker-irmAll = "docker rmi -f (docker images  -aq)";
        docker-vrmAll = "docker volume prune";
        docker-prmAll = "docker builder prune -af";
        docker-clean = "docker system prune -af"; # remove all containers, images, volumes, and networks without destroying running containers/images
        # kubernetes
        k-seal = ''
          kubectl -n "$argv[1]" get secret "$argv[2]" -o json | jq '.data | map_values(@base64d)'
        '';
        k8s-prmAll = "kubectl delete all --all --namespaces";
        k8s-prmNamespace = ''
          kubectl delete all --all -n "$argv[1]"
        '';
        # nix
        nixit = ''
          set -xg SHELL_FILE (find /home/${username}/Documents/houseOfNixAndPain/shells -name 'shell.nix' | fzf)
          nix-shell $SHELL_FILE
        '';
        nix-clean = "nix-store --gc";
        nix-update = "sudo nixos-rebuild switch";
        nix-purge = ''
          sudo nix-collect-garbage -d
          sudo nix-store --optimise
          sudo nix-env --delete-generations old
          sudo nix-env --delete-generations old --profile /nix/var/nix/profiles/system
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
        # kitty
        new_kitty_tab = "kitty @ new-tab --cwd (pwd)";
      };
      shellAbbrs = {
        l = "less";
        k = "kubectl";
      };
      shellAliases = {
        "..." = "cd ../..";
        "...." = "cd ../../..";
        ls = "eza -al";
        ":q" = "exit";
        top = "btop";
      };
    };
  };
}
