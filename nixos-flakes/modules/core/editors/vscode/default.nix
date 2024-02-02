{ username, home-manager, pkgs, ... }:
{
  home-manager.users.${username} = {
    home = {
      packages = with pkgs; [
        electron_28
      ];
    };
    programs = {
      vscode = {
        enable = true;
        # search for vscode extension
        extensions = with pkgs.vscode-extensions; [
          bbenoist.nix
          # theme
          catppuccin.catppuccin-vsc
          # ui
          usernamehw.errorlens
        ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "remote-containers";
            publisher = "ms-vscode-remote";
            version = "0.320.0";
            sha256 = "432TLuzHuXK9DmJlOpFFGlZqbWTsAWnGA8zk7/FarQw=";
          }
          {
            name = "catppuccin-vsc-icons";
            publisher = "Catppuccin";
            version = "0.29.0";
            sha256 = "bB4GrAljML5YdsRI6gU6q8tS8jXIXL5q2Kk3HDnI4RU=";
          }
        ];
      };
    };
  };
}
