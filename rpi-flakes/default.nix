{ hostname, interface, pkgs, lib, ... }:

let
  password = "root"; # temp psswd
in {
  imports = [
    ./modules/common
    "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/raspberry-pi/4"
  ];

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    kernelParams = [
      "cgroup_memory=1"
      "cgroup_enable=cpuset"
      "cgroup_enable=memory"
    ];

    initrd.availableKernelModules = [ "xhci_pci" "usbhid" "usb_storage" ];
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
      experimental-features = [ "nix-command" "flakes" ];
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

  environment.systemPackages = with pkgs; [
    git
    fd
    vim
    raspberrypi-eeprom
    k3s
    helm
    kustomize
    curl
  ];

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  users = {
    mutableUsers = false;
    users."${hostname}" = {
      isNormalUser = true;
      password = password;
      extraGroups = [ "wheel" ];
    };
  };
  security.sudo.wheelNeedsPassword = false;

  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
  };


  hardware.enableRedistributableFirmware = true;

  system.stateVersion = "23.11";
}
