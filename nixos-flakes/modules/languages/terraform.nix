{
  home-manager,
  username,
  pkgs,
  ...
}:
{
  home-manager.users.${username} = {
    home = {
      packages = with pkgs; [
        # terraform
        terraform-ls
        terraform
        terraform-docs
        terragrunt
      ];
    };
  };
}
