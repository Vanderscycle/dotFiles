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
      default = false; # ever since they now gather all of your data its not better than chromium based
    };
  };

  config = lib.mkIf config.firefox.enable {
    imports = [ ./bookmarks.nix ];
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
