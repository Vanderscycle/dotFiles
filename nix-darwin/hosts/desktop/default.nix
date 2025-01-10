{
  imports = [
    ./hardware-configuration.nix
    ./fcstab.nix
  ];
  # --- Host specific hardware ---
  hardware.cpu.amd.updateMicrocode = true;
  hardware.opengl.enable = true;
  hardware.keyboard.zsa.enable = true;
  # --- ++ [ ./keyboard.nix ];

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
    efi.canTouchEfiVariables = true;
  };

}
