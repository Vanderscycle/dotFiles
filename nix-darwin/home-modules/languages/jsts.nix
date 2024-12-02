{ pkgs, ... }:

{
  home.packages = with pkgs; [

    nodejs_18
    yarn
    corepack
    nodePackages.typescript-language-server
    nodePackages.typescript
    nodePackages.prettier
    nodePackages.eslint
    emacsPackages.import-js
  ];
}
