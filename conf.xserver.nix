module-args:

with builtins;

let

  modulesPath = module-args.modulesPath;
  configuration = module-args.configuration;
  hostname = configuration.networking.hostName;

in

  {
    services.xserver =
      if hostname == "lbnuc" then
      {
        # Enable the X11 windowing system.
        enable = true;
        resolutions = [
          { x = 1920; y = 1080; }
        ];
        # Enable the Desktop Environments.
        displayManager.sddm.enable = true;
        desktopManager.plasma5.enable = true;
      }
      else {};
  }
