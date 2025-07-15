{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11"; # Stable channel

  outputs =
    { self, nixpkgs }:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          (
            { pkgs, ... }:
            {
              # Base system configuration
              system.stateVersion = "24.11";

              # Enable flakes
              nix.settings.experimental-features = [
                "nix-command"
                "flakes"
              ];

              # User configuration
              users.users.jdoe = {
                isNormalUser = true;
                extraGroups = [ "wheel" ];
                packages = with pkgs; [
                  neovim
                  htop
                  git
                ];
              };

              # System-wide packages
              environment.systemPackages = with pkgs; [
                wget
                curl
                tmux
              ];

              # Automatic garbage collection
              nix.gc = {
                automatic = true;
                dates = "weekly";
                options = "--delete-older-than 7d";
              };

              # Optional: Enable SSH
              services.openssh.enable = true;
              networking.firewall.allowedTCPPorts = [ 22 ];

              # Set your timezone
              time.timeZone = "Europe/London";

              # Locale configuration
              i18n.defaultLocale = "en_US.UTF-8";
            }
          )

          # Include hardware configuration (generated during install)
          # ./hardware-configuration.nix
        ];
      };
    };
}
