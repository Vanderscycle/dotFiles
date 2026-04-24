{
  den,
  inputs,
  __findFile,
  ...
}:
{
  den.aspects.jebe = {
    includes = ([
      (den._.tty-autologin "")
    ]);
  };
}
