{
  home-manager,
  username,
  pkgs,
  ...
}:
{
  home-manager.users.${username} = {
    home = {
      packages = with pkgs; [

        # deno (future of node?)
        deno

        # typescript/javascript
        nodePackages.svelte-language-server
        nodePackages.typescript-language-server
        nodePackages.typescript
        nodePackages.pnpm
        yarn # like pnpm but worse
        nodejs
        nodePackages.js-beautify

        # svelte
        nodePackages.prettier
        nodePackages.eslint
        nodePackages.svelte-language-server

        # tailwindcss
        nodePackages.tailwindcss
        tailwindcss-language-server
      ];
      # file = {
      #   "npmrc".text = ''
      #     global=true
      #     prefix=$HOME/.npm-global
      #   '';
      # };
    };
  };
}
