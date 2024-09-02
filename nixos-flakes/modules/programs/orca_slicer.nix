{
  stable,
  pkgs,
  system,
  ...
}:
{
  # environment.systemPackages = with stable.legacyPackages.${system}; [ bambu-studio ];
  environment.systemPackages = with pkgs; [ orca-slicer ];
}
