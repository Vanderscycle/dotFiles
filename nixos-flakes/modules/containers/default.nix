{...}:

{
  virtualisation = {
    oci-containers = {
      backend = "docker";
      containers = {
        prusaslicer-novnc = {
          image = "mikeah/prusaslicer-novnc:latest";
          volumes = [ "/home/henri/Documents/3D-models:/data" ];
          ports = [ "4243:8080" ];
        };
      };
    };
  };
}
