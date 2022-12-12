{ ... }:

{
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "22.05"; # Did you read the comment?

  # Set your time zone.
  time.timeZone = "Asia/Hong_Kong";
  # Enable unfree packages
  nixpkgs.config.allowUnfree = true;

  # Journald logging rate limit
  services.journald.rateLimitInterval = "60s";
  services.journald.rateLimitBurst = 300;

  nix.gc = {
    automatic = true;
    dates = "03:15";
    persistent = true;
    options = "--delete-older-than 7d";
  };

  networking.nameservers = ["1.1.1.1" "1.0.0.1"];
  networking.enableIPv6 = false;
  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  # Disable network manager, all configuration shall be manually config here
  networking.networkmanager.enable = false;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;
}
