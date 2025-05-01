{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      # Package to create the system user (run as root)
      packages.${system}.create-user-script = pkgs.writeShellScriptBin "create-user" ''
        #!/bin/sh
        useradd -m -s ${pkgs.bash}/bin/bash rocky || echo "User exists"
        usermod -aG nix-users rocky
        echo "User 'rocky' created. Run 'passwd rocky' to set password"
      '';

      # Home Manager configurations
      homeConfigurations = {
        # Root user configuration (optional)
        "root" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            {
              home.username = "root";
              home.homeDirectory = "/root";
              home.stateVersion = "24.11";
              home.packages = with pkgs; [
                htop
                neovim
              ];
            }
          ];
        };

        # rocky user configuration
        "rocky" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            {
              home.username = "rocky";
              home.homeDirectory = "/home/rocky";
              home.stateVersion = "24.11";
              home.packages = with pkgs; [
                git
                tmux
                starship
              ];

              programs.bash = {
                enable = true;
                shellAliases = {
                  ll = "ls -l";
                  rebuild = "home-manager switch --flake .#newuser";
                };
              };

              home.file.".config/starship.toml".text = ''
                add_newline = false
              '';
            }
          ]
        };
      };
    };
}
