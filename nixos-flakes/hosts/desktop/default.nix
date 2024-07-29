{
  imports =
    [
      ./hardware-configuration.nix
      ./fcstab.nix
    ]
    #----Host specific hardware ----
    ++ [ ./keyboard.nix ];

}
