{ config,lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    # svelte
    nodePackages.svelte-language-server
    # typescript/javascript
    nodePackages.typescript-language-server
    # node
    nodePackages.pnpm
    nodejs

  ];
}
