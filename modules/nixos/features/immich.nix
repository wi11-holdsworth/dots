let
  port = 2283;
  certloc = "/var/lib/acme/fi33.buzz";
in
{
  services = {
    immich = {
      enable = true;
      inherit port;
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

    caddy.virtualHosts."immich.fi33.buzz".extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };
}
