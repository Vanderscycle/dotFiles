{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];
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
}
