module-args:

with builtins;

let

  modulesPath = module-args.modulesPath;
  configuration = module-args.configuration;
  hostname = configuration.networking.hostName;
  has-xserver = configuration.services.xserver.enable;

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
