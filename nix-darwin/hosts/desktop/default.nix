{
  imports = [
    ./hardware-configuration.nix
    ./fcstab.nix
  ];
  hardware.cpu.amd.updateMicrocode = true;
  hardware.keyboard.zsa.enable = true;
  # --- Host specific hardware ---
  # --- ++ [ ./keyboard.nix ];

}
