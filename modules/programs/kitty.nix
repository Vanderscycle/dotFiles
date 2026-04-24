{ ... }:
{
  steppe.program._.kitty = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [
          pkgs.kitty
        ];
      };
    homeManager =
      { pkgs, ... }:
      {
        home = {
          sessionVariables = {
            TERMINAL = "kitty";
          };
        };
        programs.kitty = {
          package = pkgs.kitty.overrideAttrs (oldAttrs: {
            # https://github.com/NixOS/nixpkgs/issues/388020
            doInstallCheck = false;
          });
          shellIntegration = {
            enableBashIntegration = true;
            enableFishIntegration = true;
            enableZshIntegration = true;
          };
          enableGitIntegration = true;
          settings = {
            allow_remote_control = "yes";
            listen_on = "unix:/tmp/kitty";
            disable_ligatures = "never";
          };
          font = {
            size = 16;
            name = "JetBrains Mono";
            package = pkgs.nerd-fonts.jetbrains-mono;
          };
        };
      };
  };
}
