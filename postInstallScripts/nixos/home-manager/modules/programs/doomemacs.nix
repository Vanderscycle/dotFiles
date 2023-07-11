{ config, pkgs, ... }:

let
  dotfiles_dir = /home/henri/Documents/dotFiles;
  doom-emacs = pkgs.callPackage
    (builtins.fetchTarball {
      url = https://github.com/nix-community/nix-doom-emacs/archive/master.tar.gz;
    })
    {
      doomPrivateDir = /home/henri/Documents/dotFiles/.config/doom; # Directory containing your config.el, init.el
    };
in
{
  home.file = {
    # doom emacs
    ".doom.d/init.el".source = "${dotfiles_dir}/.doom.d/init.el";
    ".doom.d/packages.el".source = "${dotfiles_dir}/.doom.d/packages.el";
    ".doom.d/config.el".source = "${dotfiles_dir}/.doom.d/config.el";
  };
  home.packages = [ doom-emacs ];
}
