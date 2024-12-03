{ pkgs, ... }:
{
  packages = with pkgs; [
    # nodePackages.yaml-language-server #npm i -g yaml-language-server 
    # npm i -g vscode-langservers-extracted
  ];
}
