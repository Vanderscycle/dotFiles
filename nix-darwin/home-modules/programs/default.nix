# ./ghostty.nix

{ ... }:
{
  imports = [
    ./alacritty.nix
    ./arc_browser.nix
    ./bat.nix
    ./beekeeper.nix
    ./bottles.nix
    ./brave.nix
    ./btop.nix
    ./cloud.nix
    ./codium.nix
    ./cowsay.nix
    ./devops.nix
    ./direnv.nix
    ./discord.nix
    ./fish.nix # TODO: add an option to pass to shellInit
    ./flameshot.nix
    ./fuzzel.nix
    ./fzf.nix
    ./git.nix
    ./godot.nix
    ./heroicGaming.nix
    ./k9s.nix
    ./keychain.nix
    ./kitty.nix
    ./kubernetes.nix
    ./lazygit.nix
    ./libreoffice.nix
    ./loveGameEngine.nix
    ./microcontrollers.nix
    ./modern_unix.nix
    ./multimedia.nix
    ./nh.nix
    ./nnn.nix # TODO: add more options e.g. bookmarks
    ./nushell.nix # TODO: add more options for shell init once you learn more about it
    ./nyxt.nix
    ./opencode.nix
    ./plastic_printer.nix
    ./proton.nix
    ./signal.nix
    ./spacemacs.nix
    ./spotify.nix
    ./starship.nix
    ./thunar.nix
    ./vim.nix
    ./wofi.nix
    ./zathura.nix
    ./zsh.nix # TODO: add an option like shellinit
    ./zulip.nix
  ];
}
