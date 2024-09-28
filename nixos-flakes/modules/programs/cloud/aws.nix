{ pkgs, ... }:

let
  # Define a custom awscli2 package with the patch applied
  customAwscli2 = pkgs.awscli2.overrideAttrs (oldAttrs: {
    patches = [
      # Temporary test fix until https://github.com/aws/aws-cli/pull/8838 is merged upstream
      (pkgs.fetchpatch {
        url = "https://github.com/aws/aws-cli/commit/b5f19fe136ab0752cd5fcab21ff0ab59bddbea99.patch";
        hash = "sha256-NM+nVlpxGAHVimrlV0m30d4rkFVb11tiH8Y6//2QhMI=";
      })
    ];
  });

in
{
  environment.systemPackages = with pkgs; [
    ssm-session-manager-plugin
    # customAwscli2
    awscli2
    rclone
  ];
}
