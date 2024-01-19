{ home-manager, username, pkgs, ... }:
{
  home-manager.users.${username} = {
    home = { 
      packages = with pkgs; [
        # docker
        nodePackages.dockerfile-language-server-nodejs
        hadolint

        # go
        gopls
        delve
        go-swag # swagger module for gofiber

        # typescript/javascript
        nodePackages.svelte-language-server
        nodePackages.typescript-language-server
        nodePackages.pnpm
        nodejs

        # bash
        nodePackages.bash-language-server

        # json
        nodePackages.vscode-json-languageserver

        # lua
        lua-language-server
        luajitPackages.luarocks
        luaformatter
        # nix programs
        node2nix
        nil

        # python
        python311Full
        poetry
        pre-commit
        nodePackages.pyright
       # (lib.flatten map (pkgName: python311Packages.${pkgName}) [ 
       #     black
       #     pyqt6
       #     #pyyaml
       #     #editorconfig
       #   ]
       # )

        #yaml 
        yamllint
        yamlfix
        nodePackages.yaml-language-server
      ];

      file = {
        "npmrc".text = ''
          global=true
          prefix=$HOME/.npm-global
        '';
      };
    };
    programs = {
      go = {
        enable = true;
      };
    };
  };
}
