{ home-manager, username, pkgs, ... }:
{
  home-manager.users.${username} = {
    home = {
      packages = with pkgs; [

        # sql
        sqls

        # docker
        nodePackages.dockerfile-language-server-nodejs
        hadolint

        # go
        gopls
        delve
        go-swag # swagger module for gofiber

        # php
        php

        # java
        maven
        gradle

        # emacs (pacakges)
        emacsPackages.dumb-jump

        # typescript/javascript
        nodePackages.svelte-language-server
        nodePackages.typescript-language-server
        nodePackages.pnpm
        yarn
        nodejs
        nodePackages.js-beautify
        # svelte
        nodePackages.prettier
        nodePackages.eslint
        nodePackages.svelte-language-server

        # tailwindcss
        nodePackages.tailwindcss
        tailwindcss-language-server
        rustywind

        # bash
        shellcheck
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
        nixfmt-rfc-style

        # toml
        taplo

        # terraform
        terraform-ls

        # python
        #python311
        poetry
        pre-commit
        nodePackages.pyright
        (python311.withPackages (ps: with ps; [
          toml
          python-lsp-server
          isort
          python-lsp-server
          black
          flake8
          boto3
          pyyaml
          awscli
        ]))

        #yaml
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
