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
      default = true;
    };
  };

  config = lib.mkIf config.program.zsh.enable {
    catppuccin.zsh-syntax-highlighting.enable = true;
    programs.zsh = {
      enable = true;
      initContent = ''
                    export ENTERPRISE_REPO_PATH=~/knak
                    if [[ -f $ENTERPRISE_REPO_PATH/scripts/mfa-token-loader.sh ]]; then source $ENTERPRISE_REPO_PATH/scripts/mfa-token-loader.sh; fi
                    [[ -f $ENTERPRISE_REPO_PATH/scripts/aliases ]] && source $ENTERPRISE_REPO_PATH/scripts/aliases

        # added because of homebrew
                export NVM_DIR="$HOME/.nvm"
                [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
                [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
      '';
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
