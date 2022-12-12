{ ... }:

{
  security.acme.acceptTerms = true;
  security.acme.certs = {
    "func.xyz".email = "junchih.1893@gmail.com";
    "internal.sg.baidu-ai.func.xyz".email = "junchih.1893@gmail.com";
    "1000k.cash".email = "shushu90@mail.func.xyz";
  };

  services.phpfpm.pools.mypool = {
    user = "nobody";
    settings = {
      pm = "dynamic";
      "listen.owner" = config.services.nginx.user;
      "pm.max_children" = 5;
      "pm.start_servers" = 2;
      "pm.min_spare_servers" = 1;
      "pm.max_spare_servers" = 3;
      "pm.max_requests" = 500;
    };
  };

  services.nginx.enable = true;

  services.nginx.virtualHosts."1000k.cash" = {
    forceSSL = true;
    enableACME = true;
    root = "/var/www/1000k.cash";
  };

  services.nginx.virtualHosts."func.xyz" = {
    forceSSL = true;
    enableACME = true;
    root = "/var/www/func.xyz";
    locations."/".index = "/_h5ai/public/index.php";
    locations."/_h5ai/private/".return = "403";
    locations."/_h5ai/".extraConfig = ''
      location ~ \.php$ {
        fastcgi_pass  unix:${config.services.phpfpm.pools.mypool.socket};
        fastcgi_index index.php;
      }
    '';
  };

  services.nginx.virtualHosts."internal.sg.baidu-ai.func.xyz" = {
    default = true;
    forceSSL = true;
    enableACME = true;
    root = "/var/www/internal.sg.baidu-ai.func.xyz";
    locations."/".return = "301 https://www.baidu.com$request_uri";

    locations."/dG91Y2ggbWUsIGphY2subWFvQGZ1bmMueHl6/doh-cf".proxyPass = "https://cloudflare-dns.com/dns-query";
    locations."/dG91Y2ggbWUsIGphY2subWFvQGZ1bmMueHl6/doh-88".proxyPass = "https://dns.google/dns-query";
    locations."/dG91Y2ggbWUsIGphY2subWFvQGZ1bmMueHl6/doh-op".proxyPass = "https://doh.opendns.com/dns-query";
    locations."/dG91Y2ggbWUsIGphY2subWFvQGZ1bmMueHl6/doh-q9".proxyPass = "https://dns10.quad9.net/dns-query";
  };
}
