host-name:
hardware:

{ lib, config, pkgs, ...}:
with builtins;

let
  gen-configuration =
    configuration:
    let
      my-module-args = { inherit lib config pkgs configuration; };
    in
      foldl' lib.recursiveUpdate {}
      [
        {
          imports = [ hardware ];
        }
        (import (./. + "/${host-name}.nix") my-module-args)
        (import ./customization.nix my-module-args)
      ];
  Y = X: X (Y X);
in
  Y gen-configuration
