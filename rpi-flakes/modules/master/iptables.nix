{ lib, pkgs, ... }:

{
  # Custom script to set iptables to legacy mode, if necessary
  system.activationScripts.iptables-legacy = lib.stringAfter [ "networking" ] ''
    # Commands to switch to iptables-legacy, if applicable
    ${pkgs.iptables}/bin/iptables-legacy -F
    # For ip6tables, similar approach can be taken if needed
  '';
}
