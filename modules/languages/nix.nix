{ inputs, ... }:
{
  steppe.languages._.nix = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          # Nix
          deadnix
          nix-init
          nix-inspect
          nix-prefetch-git
          nix-output-monitor
          nixpkgs-review
          nix-tree
          nix-update
          nurl
          statix
          vulnix
          nixfmt
          inputs.nix-alien.packages.${pkgs.stdenv.hostPlatform.system}.nix-alien
        ];
      };
  };
}
