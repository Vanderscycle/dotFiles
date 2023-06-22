# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, lib, config, pkgs, ... }:

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
      # neovim-nightly-overlay.overlays.default
      # If you want to use overlays exported from other flakes:
      bat

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

      BROWSER = "firefox";
      TERMINAL = "kitty";
    };
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "23.05";
    file = {
      # doom emacs
      ".doom.d/init.el".source = /home/henri/Documents/dotFiles/.doom.d/init.el;
      ".doom.d/packages.el".source = /home/henri/Documents/dotFiles/.doom.d/packages.el;
      ".doom.d/config.el".source = /home/henri/Documents/dotFiles/.doom.d/config.el;
      # kitty
      ".config/kitty/kitty.conf".source = /home/henri/Documents/dotFiles/.config/kitty/kitty.conf;
      # K9s
      ".config/k9s/config.yml".source = /home/henri/Documents/dotFiles/.config/k9s/config.yml;
      ".config/k9s/skin.yml".source = /home/henri/Documents/dotFiles/.config/k9s/skin.yml;
    };
    # of note: do not define a package here and then program.<name>.enable = true; it will cause a conflict
    packages = with pkgs; [
      # editor
      emacs
      vim
      helix
      # languages
      tldr
      luajitPackages.luarocks
      nixpkgs-fmt
      fcitx5
      fcitx5-chinese-addons
      fcitx5-configtool
      # nixos
      # home-manage
      # shell
      starship
      fish
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
      unzip
      lazygit
  systemd.user.startServices = "sd-switch";
      fzf
      yq
      silver-searcher
      ripgrep
      httpie
      xclip
      broot
      zoxide
      #nnn
      xclip
      #3d printing/cad
      super-slicer
      #devops
      k9s
      helm
      kubernetes
      docker
      ansible
      kustomize
      tilt
      terraform
      # gui
      vlc
      transmission
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
    ];
  };
  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs = {
    home-manager = {
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
    };
  };
  # Nicely reload system units when changing configs
}

}