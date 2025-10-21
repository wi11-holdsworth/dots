{
  config,
  lib,
  ...
}:
let
  port = "5013";
in
{
  services = {
    paperless = {
      enable = true;
      dataDir = "/srv/paperless";
      database.createLocally = true;
      passwordFile = config.age.secrets.paperless.path;
      port = lib.toInt port;
      settings = {
        PAPERLESS_URL = "https://paperless.fi33.buzz";
      };
    };

    borgmatic.settings = {
      postgresql_databases = [
        {
          name = "paperless";
          hostname = "localhost";
          username = "root";
          password = "{credential systemd borgmatic-pg}";
        }
      ];
    };

    nginx.virtualHosts."miniflux.fi33.buzz" = {
      forceSSL = true;
      useACMEHost = "fi33.buzz";
      locations."/".proxyPass = "http://localhost:${port}";
    };
  };

  age.secrets."paperless" = {
    file = ../../../secrets/paperless.age;
    owner = "paperless";
  };
}
