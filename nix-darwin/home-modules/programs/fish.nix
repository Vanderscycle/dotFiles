{
  lib,
  config,
  ...
}:
{
  options = {
    program.fish.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables fish shell";
      default = true;
    };
  };

  config = lib.mkIf config.program.fish.enable {
    home = {
      sessionVariables = { };
    };
    programs.fish = {
      plugins = [ ];
      enable = true;
      shellInit = ''
                 # set -x PATH $PATH $HOME/.npm-global/bin
        set ENTERPRISE_REPO_PATH ~/knak

        if test -f $ENTERPRISE_REPO_PATH/scripts/mfa-token-loader.sh
            source $ENTERPRISE_REPO_PATH/scripts/mfa-token-loader.sh
        end

        if test -f $ENTERPRISE_REPO_PATH/scripts/aliases
            # source $ENTERPRISE_REPO_PATH/scripts/aliases
            source $ENTERPRISE_REPO_PATH/scripts/aliases.sh
        end

      '';
      interactiveShellInit = '''';
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
        # there has to be a betteway (flameshot)
        # screenshot = ''
        #   grim -g "$(slurp -o -r -c '#ff0000ff')" - | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png
        # '';
        # ssh
        # v-minion-save = ''
        #   rsync -avz pi@192.168.1.243:/home/pi/printer_data/config/custom pi@192.168.1.243:/home/pi/printer_data/config/printer.cfg /home/${username}/Documents/3D-models/printer_configs/v-minion/
        # '';
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
      };
      shellAbbrs = {
        l = "less";
        kb = "kubectl";
      };
      shellAliases = {
        "..." = "cd ../..";
        "...." = "cd ../../..";
        ls = "eza -al";
        ":q" = "exit";
        top = "btop";
      };
    };
    catppuccin.fish.enable = true;
  };
}
