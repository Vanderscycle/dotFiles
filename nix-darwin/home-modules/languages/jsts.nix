{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs_18
    yarn
    corepack
    nodePackages.typescript-language-server
    nodePackages.typescript
    nodePackages.prettier # still have to install globally npm i -g prettier
    nodePackages.eslint
    emacsPackages.import-js
  ];
}
