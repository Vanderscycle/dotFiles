{
  # nixos-rebuild build --flake .#doom
  description = "My painful first foray into flakes and doomemacs";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = { url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";};
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-doom-emacs,
    ...
  }: {
    nixosConfigurations.doom = nixpkgs.lib.nixosSystem {
      system  = "x86_64-linux";
      modules = [
        home-manager.nixosModules.home-manager
        {
          home-manager.users.henri = { ... }: {
          home.stateVersion = "23.05";
          imports = [ nix-doom-emacs.hmModule ];
          programs.doom-emacs = {
            enable = true;
            doomPrivateDir = /home/henri/Documents/dotFiles/.config/doom; # Directory containing your config.el, init.el
                                       # and packages.el files
          };
        };
        }
      ];
    };
# it litterally just build home-manager
# defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;
 # defaultPackage.x86_64-linux = self.nixosConfigurations.doom;
  };
}
