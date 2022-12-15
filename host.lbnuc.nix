# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "lbnuc"; # Define your hostname.

  # Enables wireless support via wpa_supplicant.
  networking.wireless.enable = true;
  networking.wireless.networks = {
    "Cheesefield" = {
      pskRaw = "5c7f964515eea87a1cad488e45fc2f3ba5276b757e36bd8ec7c52d1e77a6dbc1";
    };
    # "free.wifi" = {};
  };

  networking.interfaces.wlp2s0.ipv4.addresses = [{
    address = "192.168.132.213";
    prefixLength = 24;
  }];
  networking.defaultGateway = "192.168.132.1";
}
