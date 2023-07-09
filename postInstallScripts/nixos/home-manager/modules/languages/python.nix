{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # python
    python310Full
    poetry
    pre-commit
    nodePackages.pyright
    python310Packages.black

    python310Packages.yamllint
    python310Packages.pyyaml
  ];

}      
