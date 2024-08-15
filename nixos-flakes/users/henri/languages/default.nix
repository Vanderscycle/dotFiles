{
  home-manager,
  hostname,
  username,
  pkgs,
  ...
}:
{
  imports = [
    ./go.nix
    ./js-ts.nix
    ./python.nix
    ./terraform.nix
    ./java.nix
  ] ++ (if hostname != "cloud" then [ ] else [ ]);
  home-manager.users.${username} = {
    home = {
      packages = with pkgs; [
        # sql
        sqls

        # docker
        nodePackages.dockerfile-language-server-nodejs
        hadolint

        # php
        php

        # emacs (pacakges)
        emacsPackages.dumb-jump

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
      ];
    };
  };
}
