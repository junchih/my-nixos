#!/usr/bin/env sh

echo "
with builtins;

let
  my-nixos =
    ./.;
in
  import my-nixos \"$(hostname)\" ./hardware-configuration.nix
"
