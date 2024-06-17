{
  fileSystems."/mnt/prox-share" = {
    device = "//192.168.1.157/test-nas";
    fsType = "cifs"; # Replace with the actual filesystem type
    options = [
      "credentials=/root/smbcreds"
      "dir_mode=0770"
      "file_mode=0770"
      "uid=1000"
      "gid=1000"
      "defaults"
    ]; # You can add more mount options here
  };
}
