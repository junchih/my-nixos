{ configuration, ...}:

let
  hostname = configuration.networking.hostName;
in
  {
    services.expressvpn.enable = hostname == "lbnuc";
  }
