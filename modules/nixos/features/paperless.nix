{
  config,
  ...
}:
let
  port = 5013;
  certloc = "/var/lib/acme/fi33.buzz";
in
{
  services = {
    paperless = {
      enable = true;
      dataDir = "/srv/paperless";
      database.createLocally = true;
      passwordFile = config.age.secrets.paperless.path;
      inherit port;
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

caddy.virtualHosts."paperless.fi33.buzz".extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };

  age.secrets."paperless" = {
    file = ../../../secrets/paperless.age;
    owner = "paperless";
  };
}
