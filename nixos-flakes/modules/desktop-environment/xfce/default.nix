{ username, pkgs, ...}:
{
  services = {
    xserver = {
      enable = true;
      desktopManager.xfce.enable = true;
      displayManager = {
        defaultSession = "xfce"; 
        lightdm.enable = true;
        autoLogin = {
	  enable = true;
	  user = "${username}";
	};
      };
    };
  };
}
