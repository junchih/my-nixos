{ lib, config, pkgs, ... }:

with builtins;

let

  host-conf = import ./configuration.nix { inherit lib config pkgs; };
  hostname = host-conf.networking.hostName;
  has-xserver = host-conf.services.xserver.enable;

in

  {
    services.xrdp =
      if has-xserver && hostname == "lbnuc" then
      {
        enable = true;
        defaultWindowManager = "startplasma-x11";
      }
      else {};
  }
