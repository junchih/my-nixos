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
	  rev = \"87a9fc272d534f8622f383c70410997e4a800b32\";
    };
"
fi
echo "
in
  import my-nixos \"$(hostname)\" ./hardware-configuration.nix
"
