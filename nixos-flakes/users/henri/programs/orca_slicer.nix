{ stable, system, ... }:
{
  environment.systemPackages = with stable.legacyPackages.${system}; [ orca-slicer ];
}
