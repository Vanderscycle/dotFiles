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
    };
  };
}
