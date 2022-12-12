#!/usr/bin/env sh

echo "
with builtins;

let
  my-nixos =
    fetchGit {
      url = \"https://github.com/junchih/nixos.git\";
      ref = \"devel\";
    };
in
  import my-nixos \"$(hostname)\" ./hardware-configuration.nix
"
