{ config, pkgs, ... }:
let
  dotfiles_dir = /home/henri/Documents/dotFiles;
in
{
  programs = {
    emacs = {
      enable = true;
    };
  };

  home = {
    # file."/.spacemacs" = {
    #  executable = true;
    #  # recursive = true;
    #   source = config.lib.file.mkOutOfStoreSymlink "${dotfiles_dir}/.config/spacemacs/.spacemacs";
    # };
    file.".emacs.d" = {
      # don't make the directory read only so that impure melpa can still happen
      # for now
      recursive = true;
      source = pkgs.fetchFromGitHub {
        owner = "syl20bnr";
        repo = "spacemacs";
        rev = "develop";
        sha256 = "0g7jvrimb1zsbiy3lcl9lbln7l9qv67jpvj2ifmxir3drxsjlr8n";
      };
    };
  };
}
