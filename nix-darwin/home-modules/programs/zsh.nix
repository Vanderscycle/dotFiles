{
  lib,
  config,
  ...
}:
{
  options = {
    program.zsh.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables zsh shell";
      default = false;
    };
    program.zsh.initContent = lib.mkOption {
      type = lib.types.str;
      default = false;
    };
  };

  config = lib.mkIf config.program.zsh.enable {
    catppuccin.zsh-syntax-highlighting.enable = true;
    programs.zsh = {
      enable = true;
      initContent = config.program.zsh.initContent;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh.enable = false;
      shellAliases = {
        ls = "eza -al";
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
      };
      shellAliases = {
        docker-crmAll = "docker rm -f (docker ps -aq)";
        docker-irmAll = "docker rmi -f (docker images  -aq)";
        docker-vrmAll = "docker volume prune";
        docker-prmAll = "docker builder prune -af";
        docker-clean = "docker system prune -af"; # remove all containers, images, volumes, and networks without destroying running containers/images
      };
    };
  };
}
