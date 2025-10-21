{
  lib,
  ...
}:
let
  port = "2283";
in
{
  services = {
    immich = {
      enable = true;
      port = lib.toInt "${port}";
      mediaLocation = "/srv/immich";
    };

    borgmatic.settings.postgresql_databases = [
      {
        name = "immich";
        hostname = "localhost";
        username = "root";
        password = "{credential systemd borgmatic-pg}";
      }
    ];

    nginx = {
      clientMaxBodySize = "50000M";
      virtualHosts."immich.fi33.buzz" = {
        forceSSL = true;
        useACMEHost = "fi33.buzz";
        locations."/" = {
          proxyPass = "http://[::1]:${port}";
          proxyWebsockets = true;
        };
      };
    };
  };
}
