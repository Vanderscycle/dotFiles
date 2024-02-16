{ username, pkgs, ... }:
{
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
