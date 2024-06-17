{
  fileSystems."/mnt/prox-share" = {
    device = "192.168.1.157/test-nas";
    fsType = "cifs"; # Replace with the actual filesystem type
    options = [
      "credentials=/root/smbcreds"
      "defaults"
    ]; # You can add more mount options here
  };
}
