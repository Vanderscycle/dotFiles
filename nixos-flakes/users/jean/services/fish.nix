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
        # FCITX input-related
        GTK_IM_MODULE = "fcitx";
        QT_IM_MODULE = "fcitx";
        XMODIFIERS = "@im=fcitx";
        GLFW_IM_MODULE = "fcitx";
        INPUT_METHOD = "fcitx";
        IMSETTINGS_MODULE = "fcitx";

        SUDO_EDITOR = "nvim";
        EDITOR = "nvim";
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
      functions = { };
      shellAbbrs = { };
      shellAliases = {
        "..." = "cd ../..";
        ls = "eza -al";
        ":q" = "exit";
        top = "btop";
      };
    };
  };
}
