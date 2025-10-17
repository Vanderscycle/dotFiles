{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./fcstab.nix
  ];
  # --- Host specific hardware ---
  hardware.cpu.amd.updateMicrocode = true;
  hardware.keyboard.zsa.enable = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      mesa
      # amdvlk replaced by RADV
    ];
    extraPackages32 = [ ];

    ## radv: an open-source Vulkan driver from freedesktop
  };

  environment.variables = {
    LD_LIBRARY_PATH = "/run/opengl-driver/lib";
  };
  # --- ++ [ ./keyboard.nix ];

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
    efi.canTouchEfiVariables = true;
  };

}
