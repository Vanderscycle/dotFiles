{ username, pkgs, ... }:
{

  # TODO: these should be the user specific
  services = {
    xserver = {
      displayManager = {
        lightdm.enable = true;
        autoLogin = {
          enable = true;
          user = "${username}";
        };
      };
    };
  };
  environment.systemPackages = with pkgs; [
    xclip
  ];
}
