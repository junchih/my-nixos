{ configuration, lib, ...}:
with lib;

let

  hostname = configuration.networking.hostName;

  maybe-attrs = optionalAttrs (
    hostname == "lbvan"
  );

in

  {
    security.acme = maybe-attrs {
      acceptTerms = true;
      certs = {
        "1000k.cash".email = "shushu90@mail.func.xyz";
      };
    };

    services.nginx = maybe-attrs {
      enable = true;
      virtualHosts."1000k.cash" = {
        forceSSL = true;
        enableACME = true;
        root = "/var/www/1000k.cash";
      };
    };
}
