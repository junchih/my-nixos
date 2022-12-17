#!/usr/bin/env sh

echo "
let
  inherit (builtins) fetchGit;
  my-nixos =
"
if [[ -v DEBUG ]];
then echo "
    ./.;
"
else echo "
    fetchGit {
      url = \"$(pwd)/.git\";
      ref = \"master\";
      rev = \"$(git rev-parse HEAD)\";
    };
"
fi
echo "
in
  import my-nixos \"$(hostname)\" [ ./hardware-configuration.nix ]
"
