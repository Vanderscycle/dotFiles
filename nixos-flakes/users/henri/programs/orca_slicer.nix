{ stable, system, ... }:
{
  environment.systemPackages = with stable.legacyPackages.${system}; [ babmu-studio # orca-slicer ];
}
