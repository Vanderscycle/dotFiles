{ lib, ... }:
{
  imports = [
    ./alacritty.nix
    ./arc_browser.nix
    ./bat.nix
    ./brave.nix
    ./btop.nix
    ./cloud.nix
    ./cowsay.nix
    ./devops.nix
    ./discord.nix
    ./firefox.nix
    ./fish.nix # TODO: add an option to pass to shellInit
    ./flameshot.nix
    ./fuzzel.nix
    ./fzf.nix
    # ./ghostty.nix
    ./git.nix
    ./k9s.nix
    ./keychain.nix
    ./kitty.nix
    ./kubernetes.nix
    ./lazygit.nix
    ./libreoffice.nix
    ./microcontrollers.nix
    ./modern_unix.nix
    ./multimedia.nix
    ./nh.nix
    ./nnn.nix # TODO: add more options e.g. bookmarks
    ./nushell.nix # TODO: add more options for shell init once you learn more about it
    ./plastic_printer.nix
    ./signal.nix
    ./spacemacs.nix
    ./spotify.nix
    ./starship.nix
    ./thunar.nix
    ./vim.nix
    ./zathura.nix
    ./zsh.nix # TODO: add an option like shellinit
    ./zulip.nix
  ];
}
