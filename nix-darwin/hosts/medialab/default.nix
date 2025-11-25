{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    # ./fcstab.nix
  ];
  # --- Host specific hardware ---
  hardware.cpu.intel.updateMicrocode = true;

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
    efi.canTouchEfiVariables = true;
  };

}
