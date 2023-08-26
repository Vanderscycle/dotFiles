{ config, pkgs, lib, ... }:

let
  dotfiles_dir = /home/henri/Documents/dotFiles;
in
{
  home.packages = (with pkgs ;[
    gcc
    cargo
    nerdfonts
  ]);
  programs = {
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withPython3 = true;
      extraPackages = (with pkgs ;[ tree-sitter nodejs ripgrep fd unzip ]);
    };
  };

  # nix-prefect-git <repo>
  home = {
    file = {
      "nyoom.nvim" = {
        source = pkgs.fetchFromGitHub {
          owner = "shaunsingh";
          repo = "nyoom.nvim";
          rev = "947afef56a58e3d926e424d2c3d37194d357a40e";
          sha256 = "1bqc7w5vvr38xjab80mfn69l6cdqr4b4ill2qpi8hysjpgh26nbg";
        };
        target = ".config/nvim";
        recursive = true;
      };
      # config files
      # ".config/nvim/fnl/packages.fnl".source = "${dotfiles_dir}/.config/nyoom/packages.fnl";
      # ".config/nvim/fnl/macros.fnl".source = "${dotfiles_dir}/.config/nyoom/macros.fnl";
      # ".config/nvim/fnl/config.fnl".source = "${dotfiles_dir}/.config/nyoom/config.fnl";
      # ".config/nvim/fnl/modules.fnl".source = "${dotfiles_dir}/.config/nyoom/modules.fnl";
    };
  };
}
