{ config,lib, pkgs, ... }:

{

  home.file."npmrc".text = ''
    global=true
    prefix=$HOME/.npm-global
  '';

  home.packages = with pkgs; [
    # (pkgs.nodejs.override { package = pkgs.pnpm; })
    # svelte
    nodePackages.svelte-language-server
    # typescript/javascript
    nodePackages.typescript-language-server
    # node
    nodePackages.pnpm
    nodejs
    # lsp
    # bash
    nodePackages.bash-language-server
    # json
    nodePackages.vscode-json-languageserver
  ];
}
