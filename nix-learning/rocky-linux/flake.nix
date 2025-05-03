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
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system}.create-user-script = pkgs.writeShellScriptBin "create-user" ''
        #!/bin/sh
        useradd -m -s /bin/bash rocky
        echo "User 'rocky' created. Run 'passwd rocky' to set password"
      '';

      homeConfigurations = {
        "rocky" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          # Pass extraSpecialArgs here instead of in the module
          extraSpecialArgs = {
            inherit inputs;
            username = "rocky";
            hostname = "rocky-nix";
            system = "x86_64-linux";
          };
          modules = [
            ./home.nix
            {
              home = {
                homeDirectory = "/home/rocky";
                stateVersion = "25.05";
                packages = with pkgs; [
                  git
                  tmux
                ];
              };
              programs.starship = {
                enable = true;
                enableBashIntegration = true;
              };

              programs.bash = {
                enable = true;
                shellAliases = {
                  ll = "ls -l";
                  rebuild = "home-manager switch --flake .#rocky";
                };
              };

              home.file.".config/starship.toml".text = ''
                add_newline = false
              '';
            }
          ];
        };
      };
    };
}
