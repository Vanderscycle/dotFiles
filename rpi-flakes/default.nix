{
  hostname,
  interface,
  pkgs,
  lib,
  ...
}:

{

  imports = [ ./common ];
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    kernelParams = [
      "cgroup_memory=1"
      "cgroup_enable=cpuset"
      "cgroup_enable=memory"
    ];

    initrd.availableKernelModules = [
      "xhci_pci"
      "usbhid"
      "usb_storage"
    ];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  networking = {
    hostName = hostname;
    wireless = {
      enable = false;
      interfaces = [ interface ];
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        6443
        6444
        9000
      ];
    };
  };

  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    git
    fd
    ag
    lunarvim
    raspberrypi-eeprom
    helm
    kustomize
    curl
    wget
  ];

  # sops.secrets.k3s_token = {
  #   sopsFile = ./secrets.yaml;
  # };

  # services.k3s.tokenFile = config.sops.secrets.k3s_token.path;

  # sops = {
  #   age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  # };

  services.tailscale.enable = true;
  services.k3s.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  security.sudo.wheelNeedsPassword = false;
  hardware.enableRedistributableFirmware = true;
  system.stateVersion = "24.05";
}
