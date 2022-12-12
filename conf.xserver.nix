{ configuration, lib, ...}:
with lib;

let

  hostname = configuration.networking.hostName;

  maybe-attrs = optionalAttrs (
    hostname == "lbnuc"
  );

in

  {
    services.xserver = maybe-attrs {
      # Enable the X11 windowing system.
      enable = true;
      resolutions = [
        { x = 1920; y = 1080; }
      ];
      # Enable the Desktop Environments.
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
    };
  }
