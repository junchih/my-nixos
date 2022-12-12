#!/usr/bin/env sh

echo "
with builtins;

let
  my-nixos =
"
if [[ -v DEBUG ]];
then echo "
    ./.;
"
else echo "
    fetchGit {
      url = \"https://github.com/junchih/nixos.git\";
      ref = \"master\";
      rev = \"$(git rev-parse HEAD)\";
    };
"
fi
echo "
in
  import my-nixos \"$(hostname)\" ./hardware-configuration.nix
"
