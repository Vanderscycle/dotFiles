{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  options = {
    program.spotify.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables paid music";
      default = true;
    };
  };

  imports = [ inputs.spicetify-nix.homeManagerModules.default ];
  config = lib.mkIf config.program.spotify.enable {
    nixpkgs.config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "spotify"
      ];
    programs.spicetify =
      let
        spicetifyPkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
      in
      {
        theme = spicetifyPkgs.themes.catppuccin;
        colorScheme = "mocha";
        enable = true;
        enabledCustomApps = with spicetifyPkgs.apps; [
          betterLibrary
          historyInSidebar
          localFiles
          lyricsPlus
          marketplace
          nameThatTune
        ];
        enabledExtensions = with spicetifyPkgs.extensions; [
          adblock
          beautifulLyrics
          hidePodcasts
          history
          shuffle
          volumePercentage
        ];
      };
  };
}
