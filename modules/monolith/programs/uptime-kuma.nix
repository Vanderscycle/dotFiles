{ ... }:
{
  stars.program._.uptime-kuma = {
    nixos = {
      services.uptime-kuma = {
        enable = true;
        appriseSupport = true;
        settings = {
          PORT = "4100";
        };
      };
    };
    homeManager = {
    };
  };
}
