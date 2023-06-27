# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, lib, config, pkgs, ... }:
let
  dotfiles_dir = /home/henri/Documents/dotFiles;
in
{
  # You can import other home-manager modules here
  imports = [
    # ./modules/services
    ./modules/programs
  ];
  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };
  home = {
    username = "henri";
    homeDirectory = "/home/henri";
    sessionVariables = {
      EDITOR = "helix";
      RIPGREP_CONFIG_PATH = "$HOME/.config/rg";
      BROWSER = "firefox";
      TERMINAL = "wezterm";
NNN_PLUG = "f:finder;o:fzopen;v:imgview;p:preview-tui;t:preview-tabbed";
NNN_OPTS = "Hed";
    };
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "23.05";
    file = {
      # doom emacs
      # ".doom.d/init.el".source = "${dotfiles_dir}/.doom.d/init.el";
      # ".doom.d/packages.el".source = "${dotfiles_dir}/.doom.d/packages.el";
      # ".doom.d/config.el".source = "${dotfiles_dir}/.doom.d/config.el";
      # ripgrep
      ".config/rg/.ripgreprc".source = "${dotfiles_dir}/.config/rg/.ripgreprc";
      # kitty
      ".config/kitty/kitty.conf".source = "${dotfiles_dir}/.config/kitty/kitty.conf";
      # discord
      ".config/discord/settings.json".source = "${dotfiles_dir}/.config/discord/settings.json";
      # helix
      ".config/helix/config.toml".source = "${dotfiles_dir}/.config/helix/config.toml";
      ".config/helix/languages.toml".source = "${dotfiles_dir}/.config/helix/languages.toml";
      # broot
      ".config/broot/conf.hjson".source = "${dotfiles_dir}/.config/broot/conf.hjson";
      # awesome wm
      "awesome" = {
        source = "${dotfiles_dir}/.config/awesome";
        target = "./.config/awesome";     
        };
      "xprofile" = {
        source = "${dotfiles_dir}/.config/.xprofile";
        target = "./.xprofile";
      };
      # K9s
      ".config/k9s/config.yml".source = "${dotfiles_dir}/.config/k9s/config.yml";
      ".config/k9s/skin.yml".source = "${dotfiles_dir}/.config/k9s/skin.yml";
    };
    # of note: do not define a package here and then program.<name>.enable = true; it will cause a conflict
    packages = with pkgs; [
      # languages /fonts
      noto-fonts-emoji
      tldr
      nixpkgs-fmt
      ripgrep
      # fcitx5
      # fcitx5-chinese-addons
      # fcitx5-configtool
      # programming
      #terraform
      terraform-ls
      # svelte
      nodePackages.svelte-language-server
      # lua
      lua-language-server
      luajitPackages.luarocks
luaformatter
      # toml
      taplo
      # yaml
      nodePackages.yaml-language-server
      # json
      nodePackages.vscode-json-languageserver
      # nix
      nil
      # bash
      nodePackages.bash-language-server
      shellcheck
      # python
      nodePackages.pyright
      poetry
      black
      # go
      gopls
      delve
      # typescript/javascript
      nodePackages.typescript-language-server
      # node
      nodePackages.pnpm
      nodejs
      # shell
      starship
      fishPlugins.done
      fishPlugins.fzf
      fishPlugins.autopair
      fishPlugins.z
      kitty
      gnupg
      pinentry
      # client
      awscli2
      linode-cli
      # cli
      sysz
      fd
      rsync
      exa
      bat
      lazygit
      unzip
      fzf
      yq
      jq
      silver-searcher
      httpie
      xclip
      zoxide
      xclip
      #3d printing/cad
      super-slicer-latest
      #devops
      dogdns
      k9s
      kubernetes-helm
      kubernetes
      ansible
      kustomize
      tilt
      terraform
      # gui/
nitrogen
      signal-desktop
      gparted
      vlc
      transmission-gtk
      xfce.thunar
      xfce.thunar-volman
      lxappearance
      insomnia
      slack
      firefox
      # social
      zoom
      discord
      betterdiscordctl
      spotify
      spicetify-cli
      # gaming	
      steam
      flameshot
    ];
  };
  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];
  # Enable home-manager and git
  services = {
    gpg-agent = {
      enableSshSupport = true;
    };

  };
  programs = {
    gpg = {
      enable = true;
    };
    ssh = {
      #     enable = true;
      includes = [ "$HOME/.ssh/endeavourGit" ];
    };
    starship = {
      enable = true;
    };
    keychain = {
      enable = true;
      keys = [ "$HOME/.ssh/endeavourGit"];
    };
    home-manager = {
      enable = true;
    };
    rofi = {
      enable = true;
    };
    broot = {
      enable = true;
    };
    kitty = {
      theme = "tokyo_night_night";
    };
    wezterm = {
      enable = true;
      extraConfig = ''
      -- Your lua code / config here
-- local mylib = require 'mylib';
return {
  -- usemylib = mylib.do_fun();
  font = wezterm.font("JetBrains Mono"),
  font_size = 16.0,
  color_scheme = "Tomorrow Night",
  hide_tab_bar_if_only_one_tab = true,
}
      '';
    };
    btop = {
      enable = true;
      settings = {
        color_theme = "tokyo-night";
        theme_background = true;
      };
    };
    git = {
      enable = true;
      userEmail = "henri-vandersleyen@protonmail.com";
      userName = "vanderscycle";
      # commit = {
      #   gpgsign = true;
      # };
      extraConfig = {
        user.signingkey = "~/.ssh/endeavourGit.pub";
        gpg = {
          format = "ssh";
        };
      };
      signing = {
        key = "AAAAC3NzaC1lZDI1NTE5AAAAIOYTNJEemZVjjyRY57nQRj4NHLL58aR1U5CyAsGtuUD3";
      };
    };
    helix = {
      enable = true;

    };
    go = {
      enable = true;
    };
  };
# INFO used for lxappearance dark mode theme
  gtk = {
    enable = true;
    theme = {
      name = "Materia-dark";
      package = pkgs.materia-theme;
                };
  gtk3 = {
    extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };
  };
  qt = {
    style = {
      package = pkgs.adwaita-qt;
      name = "adwaita-dark";
    };
  };
  xsession = {
    windowManager.awesome.enable = true;
  }; # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

}
