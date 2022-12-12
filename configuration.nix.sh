#!/usr/bin/env sh

echo "
{ lib, config, pkgs, ... }:

with builtins;

foldl' lib.recursiveUpdate {}
[
  {
    imports = [
      ./hardware-configuration.nix
    ];
  }
  (import ./$(hostname).nix { inherit lib config pkgs; })
  (import ./customization.nix { inherit lib config pkgs; })
]
"
