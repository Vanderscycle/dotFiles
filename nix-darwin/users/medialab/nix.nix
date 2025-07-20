{ meta, inputs, ... }:
{
  nix = {
    optimise.automatic = true;
    settings = {
      warn-dirty = false;
      experimental-features = "nix-command flakes";
      substituters = [ ];
      trusted-public-keys = [ ];
    };

    gc = {
      automatic = true;
      options = "--delete-older-than 14d";
    };

    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ]; # for nix.nix
  };

  nixpkgs = {
    hostPlatform = meta.system;
    config.allowUnfree = true;
  };
}
