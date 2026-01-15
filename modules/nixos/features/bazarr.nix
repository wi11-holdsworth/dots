let
  port = 5017;
  certloc = "/var/lib/acme/fi33.buzz";
in
{
  services = {
    bazarr = {
      enable = true;
      dataDir = "/srv/bazarr";
      group = "srv";
      listenPort = port;
    };

    borgmatic.settings.sqlite_databases = [
      {
        name = "bazarr";
        path = "/srv/bazarr/db/bazarr.db";
      }
    ];

    caddy.virtualHosts."bazarr.fi33.buzz".extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };
}
