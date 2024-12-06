{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nixfmt-rfc-style
    nixd #https://emacs-lsp.github.io/lsp-mode/page/lsp-nix-nixd/
  ];
}
