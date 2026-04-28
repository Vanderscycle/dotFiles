{
  inputs,
  lib,
  den,
  __findFile,
  ...
}:
{
  den.default = {
    includes = [
      #  <den/home-manager>
      <den/define-user>
      <den/hostname>
      # <den/inputs>
      # <den/self>
      <steppe/languages/nix>
      <steppe/xdg>
      (
        { host, ... }:
        {
          ${host.class}.networking.hostName = host.name;
        }
      )
    ];
    nixos = {
      imports = with inputs; [
        nixos-facter-modules.nixosModules.facter
      ];
      system.stateVersion = "25.11";
      # powerManagement.enable = true; # issues w/kvm
      home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;
      };
      boot.initrd.systemd.enable = true;

      nixpkgs.config.allowUnfree = true;
      # programs.nix-index-database.comma.enable = true;
      # programs.nix-ld.enable = true;
      nix = {
        optimise.automatic = false;
        registry.nixpkgs.flake = inputs.nixpkgs;
        gc.automatic = true;
        settings = {
          keep-outputs = true;
          keep-derivations = true;
          use-xdg-base-directories = true;
          auto-optimise-store = true;
          experimental-features = "nix-command flakes";
          substituters = [ "https://hyprland.cachix.org" ];
          trusted-substituters = [ "https://hyprland.cachix.org" ];
          trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
        };
      };
    };
    homeManager = {
      home = {
        sessionPath = [ "$HOME/.local/bin" ];
        sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";
        stateVersion = "25.11";
      };
    };
  };

  # enable hm by default
  den.schema.user.classes = lib.mkDefault [ "homeManager" ];

  # host<->user provides
  den.ctx.user.includes = [ den._.mutual-provider ];

}
