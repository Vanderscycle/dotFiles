{
  hostname,
  pkgs,
  config,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    k3s
  ];
  services.k3s = {
    enable = true;
    role = "server";
    token = config.sops.secrets."k3_token".path;
    extraFlags = toString (
      [
        "--write-kubeconfig-mode \"0644\""
        "--cluster-init"
        "--disable servicelb"
        "--disable traefik"
        "--disable local-storage"
      ]
      ++ (
        if hostname == "homelab-0" then
          [ ]
        else
          [
            "--server https://homelab-0:6443"
          ]
      )
    );
    clusterInit = (hostname == "homelab-0");
  };

  services.openiscsi = {
    enable = true;
    name = "iqn.2016-04.com.open-iscsi:${hostname}";
  };

}
