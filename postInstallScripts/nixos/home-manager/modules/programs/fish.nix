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
      docker-crmAll = "docker rm -f (docker ps -aq)";
      docker-irmAll = "docker rmi -f (docker images  -aq)";
      docker-vrmAll = "docker volume prune";
      docker-prmAll = "docker builder prune -af";
      k-seal = ''
        kubectl -n "$argv[1]" get secret "$argv[2]" -o json | jq '.data | map_values(@base64d)'
      '';
      k8s-prmAll = "kubectl delete all --all --namespaces";
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
    };
  };
}
