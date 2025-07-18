{
  pkgs,
  inputs,
  system ? builtins.currentSystem,
  username,
  lib,
  config,
  ...
}:
{
  options = {
    firefox.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enables firefox";
      default = false;
    };
  };

  config = lib.mkIf config.firefox.enable {
    programs.firefox = {
      enable = true;
      profiles.${username} = {

        search.default = "DuckDuckGo";
        search.engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
        };
        search.force = true;

        bookmarks = [
          {
            name = "wikipedia";
            tags = [ "wiki" ];
            keyword = "wiki";
            url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
          }
          {
            name = "home-manager";
            tags = [
              "docs"
              "nixos"
            ];
            keyword = "docs";
            url = "https://nix-community.github.io/home-manager/options.xhtml";
          }
          {
            name = "nix packages";
            tags = [ "nixos" ];
            keyword = "nixos";
            url = "https://search.nixos.org/packages";
          }
          {
            name = "GitHub";
            tags = [ "coding" ];
            keyword = "coding";
            url = "https://github.com/Vanderscycle";
          }
          {
            name = "yt-dreamsOfAutonomy";
            tags = [
              "yt"
              "coding"
            ];
            keyword = "yt";
            url = "https://www.youtube.com/@dreamsofautonomy";
          }
          {
            name = "yt-dreamsOfAutonomy";
            tags = [
              "yt"
              "coding"
            ];
            keyword = "yt";
            url = "https://www.youtube.com/@dreamsofautonomy";
          }
        ];

        settings = {
          "dom.security.https_only_mode" = true;
          "browser.download.panel.shown" = true;
          "identity.fxaccounts.enabled" = false;
          "signon.rememberSignons" = false;
        };

        extensions = with inputs.firefox-addons.packages.${system}; [
          ublock-origin
          sponsorblock
          darkreader
          youtube-shorts-block
        ];
      };
    };
  };
}
