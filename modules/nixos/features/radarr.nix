let
  port = 5007;
  certloc = "/var/lib/acme/fi33.buzz";
in
{
  services = {
    radarr = {
      enable = true;
      dataDir = "/srv/radarr";
      settings.server = {
        inherit port;
      };
      group = "srv";
    };

    borgmatic.settings.sqlite_databases = [
      {
        name = "radarr";
        path = "/srv/radarr/radarr.db";
      }
    ];

    caddy.virtualHosts."radarr.fi33.buzz".extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };
}
