{ configuration, lib, ...}:
with lib;

let

  hostname = configuration.networking.hostName;
  has-xserver = attrByPath ["services""xserver""enable"] false configuration;

  maybe-attrs = optionalAttrs (
    has-xserver &&
    hostname == "lbnuc"
  );

in

  {
    services.xrdp = maybe-attrs {
      enable = trace "Enable RDP service" true;
      defaultWindowManager = "startplasma-x11";
    };
  }
