# defines all hosts + users + homes.
# then config their aspects in as many files you want
{
  # temujin (root)
  den.hosts.x86_64-linux.temujin.users.khan = { };
  # subutai ()
  den.hosts.x86_64-linux.subutai.users.ilkhan = { };
  # jebe (deck)
  den.homes.x86_64-linux.jebe.yurtchi = { };

  # be sure to add nix-darwin input for this:
  # den.hosts.aarch64-darwin.apple.users.alice = { };

  # other hosts can also have user tux.
  # den.hosts.x86_64-linux.south = {
  #   wsl = { }; # add nixos-wsl input for this.
  #   users.tux = { };
  #   users.orca = { };
  # };
}
