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
#EDITOR = "emacs";
    };
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "23.05";
    file = { };
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
      home-manager
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
      bat
      lazygit
      unzip
      fzf
      yq
      silver-searcher
      ripgrep
      btop
      httpie
      xclip
      broot
      zoxide
      nnn
      xclip
      #3d printing/cad
      super-slicer-latest
      #devops
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
    git = {
enable = true;
};
  };
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

}