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

    languages.jsts.vue.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables vue/nuxt framework";
      default = false;
    };

    languages.jsts.svelte.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables svelte framework";
      default = false;
    };
  };

  config = lib.mkIf config.languages.jsts.lsp.enable {
    home.packages =
      with pkgs;
      [
        nodejs-slim_22
        corepack
        nodePackages.typescript-language-server
        nodePackages.typescript
        nodePackages.prettier # still have to install globally npm i -g prettier
        nodePackages.eslint
        emacsPackages.import-js
        svelte-language-server # npm install -g svelte-language-server
      ]
      ++ (
        if config.languages.jsts.vue.enable then
          [
            vue-language-server
            vscode-extensions.vue.volar
          ]
        else
          [ ]
      )
      ++ (if config.languages.jsts.svelte.enable then [ svelte-language-server ] else [ ]);
  };
}
