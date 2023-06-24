# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, lib, config, pkgs, ... }:
let
  dotfiles_dir = /home/henri/Documents/dotFiles;
in
#TODO figure it out with fcitx
#i8n.inputMethod.fcitx5.addons = with pkgs; [  fcitx5-chinese-addons ];
{
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
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
      TERMINAL = "kitty";
    };
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "23.05";
    file = {
      # doom emacs
      ".doom.d/init.el".source = "${dotfiles_dir}/.doom.d/init.el";
      ".doom.d/packages.el".source = "${dotfiles_dir}/.doom.d/packages.el";
      ".doom.d/config.el".source = "${dotfiles_dir}/.doom.d/config.el";
      # fish
      #".config/fish/config.fish".source = "${dotfiles_dir}/config.fish";
      # ripgrep
      ".config/rg/.ripgreprc".source = "${dotfiles_dir}/.config/rg/.ripgreprc";
      # kitty
      ".config/kitty/kitty.conf".source = "${dotfiles_dir}/.config/kitty/kitty.conf";
      # discord
      ".config/discord/settings.json".source = "${dotfiles_dir}/.config/discord/settings.json";
     # helix
      ".config/helix/config.toml".source = "${dotfiles_dir}/.config/helix/config.toml";
      # awesome wm
    # "awesome" = {
    #   source = "${dotfiles_dir}/.config/awesome";
    #   target = "./.config/awesome";     
    #   };
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
      luajitPackages.luarocks
      nixpkgs-fmt
      ripgrep
      fcitx5
      fcitx5-chinese-addons
      fcitx5-configtool
      # shell
      starship
      fishPlugins.done
      fishPlugins.fzf
      fishPlugins.autopair
      fishPlugins.z
      kitty
      wezterm
      git
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
      silver-searcher
      httpie
      xclip
      broot
      zoxide
      xclip
      #3d printing/cad
      super-slicer-latest
      #devops

dogdns
      k9s
      helm
      kubernetes
      docker
      ansible
      kustomize
      tilt
      terraform
poetry
      # gui
nitrogen
signal-desktop
      gparted
      vlc
      transmission-gtk
      xfce.thunar
      nitrogen
      #insomniac
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
 includes = ["$HOME/.ssh/endeavourGit"];
  };
  fish = {
    enable = true;
    shellAbbrs = {
      l = "less";
         };
    shellAliases = {
      "..." = "cd ../..";
         ls = "exa -al";
    };
    
  };
    home-manager = {
      enable = true;
    };
    rofi = {
      enable = true;
    };
    nnn = {
      enable = true;
      package = pkgs.nnn.override ({ withNerdIcons = true; });
      bookmarks = {
        d = "~/Documents";
        D = "~/Downloads";
        p = "~/Pictures";
        v = "~/Videos";
      };
    };
    kitty = {
      theme = "tokyo_night_night";
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
      extraConfig = {
        user.signingkey = "~/.ssh/endeavourGit.pub";
        gpg = {
          format = "ssh";
          };
        };
    #  signing = {
    #    key = "2664645CF72BE38A";
    #  };
    };
    helix = {
      enable = true;
      
    };
    };

  xsession = {
    windowManager.awesome.enable = true;
  };  # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

}
