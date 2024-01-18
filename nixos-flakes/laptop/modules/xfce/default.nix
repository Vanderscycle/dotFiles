{ username, pkgs, ...}:
{
  services = {
    xserver = {
      desktopManager.xfce.enable = true;
      displayManager = {
        lightdm.enable = true;
	autologin = {
	  enable = true;
	  user = $username
	};
      };
    };
  };
}
