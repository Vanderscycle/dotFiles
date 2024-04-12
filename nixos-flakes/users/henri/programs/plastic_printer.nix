{pkgs, ...}:
{
  environment.systemPackages = with pkgs;[
    super-slicer-beta
    orca-slicer
  ]; 
}
