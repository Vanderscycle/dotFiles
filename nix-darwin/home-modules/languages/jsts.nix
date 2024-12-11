{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    jsts.lsp.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables js and ts lsp";
      default = false;
    };
  };

  config = lib.mkIf config.jsts.lsp.enable {
    home.packages = with pkgs; [
      nodejs_18
      yarn
      corepack
      nodePackages.typescript-language-server
      nodePackages.typescript
      nodePackages.prettier # still have to install globally npm i -g prettier
      nodePackages.eslint
      emacsPackages.import-js
      vue-language-server # npm install -g volar
      svelte-language-server # npm install -g svelte-language-server
    ];
  };
}
