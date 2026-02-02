{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    languages.jsts.lsp.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables js and ts lsp";
      default = false;
    };
  };

  config = lib.mkIf config.languages.jsts.lsp.enable {
    home.packages = with pkgs; [
      nodejs_22
      bun
      # corepack # contains pnpm/yarn/npm
      nodePackages.typescript-language-server
      nodePackages.typescript
      nodePackages.prettier # still have to install globally npm i -g prettier
      nodePackages.eslint
      emacsPackages.import-js
      # npm install -g svelte-language-server
    ];
  };
}
