package main

import "endavourOs/install"

func main() { s := install.EssentialPackages; install.Installer(s...) }
