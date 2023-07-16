{ config, pkgs, ... }:
{
  # fishPlugins.done
  # fishPlugins.fzf
  # fishPlugins.autopair
  # fishPlugins.z

  programs.fish = {
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

    functions = {

      # cloud access
      cloud-linode = ''
        set -xg KUBECONFIG $HOME/.kube/infrastructure-kubeconfig.yaml
      '';
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
      # nnn
      n = ''
        nnn $argv -P p
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
    };
    shellAbbrs = {
      l = "less";
      k = "kustomize";
    };
    shellAliases = {
      "..." = "cd ../..";
      ls = "exa -al";
      dig = "dog";
      ":q" = "exit";
      top = "btop";
      nyoom = "~/.config/nvim/bin/nyoom $argv";
    };
  };
}
