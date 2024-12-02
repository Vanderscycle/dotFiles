{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    initExtra = ''
      export ENTERPRISE_REPO_PATH=~/knak
      if [[ -f $ENTERPRISE_REPO_PATH/scripts/mfa-token-loader.sh ]]; then source $ENTERPRISE_REPO_PATH/scripts/mfa-token-loader.sh; fi
      [[ -f $ENTERPRISE_REPO_PATH/scripts/aliases ]] && source $ENTERPRISE_REPO_PATH/scripts/aliases
    '';
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    syntaxHighlighting.catppuccin.enable = true;
    oh-my-zsh.enable = false;
    shellAliases = {
      ls = "eza -al";
      ".." = "cd ..";
      "..." = "cd ../..";
    };
  };
}
