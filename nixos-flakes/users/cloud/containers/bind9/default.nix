{ username, home-manager, ... }:
let
  true_nas_smb = "/mnt/prox-share";
  container_name = "bind9";
  dotfiles_dir = /home/${username}/Documents/dotFiles/nixos-flakes/users/${username}/containers/${container_name}; # can't we use pwd?
in
{

  home-manager.users.${username} = {
    home = {
      file = {
        "${true_nas_smb}/${container_name}/config" = {
          recursive = true;
          source = "${dotfiles_dir}/config";
        };
        "${true_nas_smb}/${container_name}/cache".recursive = {
          recursive = true;
          source = "${dotfiles_dir}/cache";
        };
        "${true_nas_smb}/${container_name}/records" = {
          recursive = true;
          source = "${dotfiles_dir}/records";
        };
      };
    };
  };
  services.resolved = {
    # Disable local DNS stub listener on 127.0.0.53
    extraConfig = ''
      DNSStubListener=no
    '';
  };

  virtualisation = {
    oci-containers = {
      containers = {
        bind9 = {
          image = "ubuntu/${container_name}:latest";
          ports = [
            "53:53/tcp"
            "53:53/udp"
          ];
          volumes = [
            "${true_nas_smb}/${container_name}/config:/etc/bind"
            "${true_nas_smb}/${container_name}/cache:/var/cache/bind"
            "${true_nas_smb}/${container_name}/records:/var/lib/bind"
          ];
          environment = {
            BIND9_USER = "root";
            PUID = "1000";
            PGID = "1000";
            TZ = "America/Vancouver";
          };
        };
      };
    };
  };
}
