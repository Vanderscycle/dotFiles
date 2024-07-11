{ pkgs, ... }:
{
  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    systemd-boot.configurationLimit = 10;
    grub.catppuccin.enable = true;
  };
}
