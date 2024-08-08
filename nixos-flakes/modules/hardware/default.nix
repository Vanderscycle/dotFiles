{
  imports = [
    ./bluetooth.nix
    ./network.nix
    ./sound.nix
    ./firewall.nix
  ];
  hardware.cpu.amd.updateMicrocode = true;
}
