{ home-manager, username, pkgs, ... }:
{
  home-manager.users.${username} = {
    home = {
      packages = with pkgs; [
        # docker
        nodePackages.dockerfile-language-server-nodejs
        hadolint

        # bash
        shellcheck

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
        nodejs
        # svelte
        nodePackages.prettier
        nodePackages.eslint
        nodePackages.svelte-language-server

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
          pyls-isort
          black
          flake8
          boto3
          pyyaml
          awscli
        ]))

        #yaml  #not working at all
        #yamllint
        #yamlfix
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
