{ pkgs, ... }:
{
  # https://devenv.sh/getting-started/#1-install-nix
  home = {
    packages = with pkgs; [
      cachix
    ];
  };
}
