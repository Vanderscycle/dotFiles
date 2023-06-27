{ pkgs, ... }:

let
  doom-emacs = pkgs.callPackage
    (builtins.fetchTarball {
      url = https://github.com/nix-community/nix-doom-emacs/archive/master.tar.gz;
    })
    {
      doomPrivateDir = /home/henri/Documents/dotFiles/.config/doom; # Directory containing your config.el, init.el
    };
in
{
  home.packages = [ doom-emacs ];
}
