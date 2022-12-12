#!/usr/bin/env sh

echo "
module-args:

with builtins;

let
  lib = module-args.lib;
  my-nixos = fetchGit {
    url = \"https://github.com/junchih/nixos.git\";
    ref = \"devel\";
  };
  modulesPath = my-nixos;
  gen-configuration =
    configuration:
    let
      my-module-args = module-args // { configuration = configuration; };
    in
      foldl' lib.recursiveUpdate {}
      [
        {
          imports = [
            ./hardware-configuration.nix
          ];
        }
        (import (modulesPath + /$(hostname).nix) my-module-args)
        (import (modulesPath + /customization.nix) my-module-args)
      ];
  Y = X: X (Y X);
in
  Y gen-configuration
"
