let
  port = 2283;
  certloc = "/var/lib/acme/fi33.buzz";
  hostname = "photos.fi33.buzz";
  url = "https://${hostname}";
in
{
  services = {
    immich = {
      enable = true;
      inherit port;
      mediaLocation = "/srv/immich";
    };

    gatus.settings.endpoints = [
      {
        name = "Immich";
        group = "Media Streaming";
        inherit url;
        interval = "5m";
        conditions = [
          "[STATUS] == 200"
          "[CONNECTED] == true"
          "[RESPONSE_TIME] < 500"
        ];
      }
    ];

    borgmatic.settings.postgresql_databases = [
      {
        name = "immich";
        hostname = "localhost";
        username = "root";
        password = "{credential systemd borgmatic-pg}";
      }
    ];

    caddy.virtualHosts.${hostname}.extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };
}
