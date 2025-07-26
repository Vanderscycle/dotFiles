{
  pkgs ? import <nixpkgs> { },
  ...
}:
let
  exampleScript = pkgs.writers.writeJS "example" { libraries = [ pkgs.uglify-js ]; } ''
    var UglifyJS = require("uglify-js");
    var code = "function add(first, second) { return first + second; }";
    var result = UglifyJS.minify(code);
    console.log(result.code);
  '';
in
{
  # Make the script available on the system
  # environment.systemPackages = [
  #   exampleScript
  # ];
}
