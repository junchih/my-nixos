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
      enable = true;
      defaultWindowManager = "startplasma-x11";
    };
  }
