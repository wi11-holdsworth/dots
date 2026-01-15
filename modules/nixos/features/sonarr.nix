let
  port = 5006;
  certloc = "/var/lib/acme/fi33.buzz";
in
{
  services = {
    sonarr = {
      enable = true;
      dataDir = "/srv/sonarr";
      settings.server = {
        inherit port;
      };
      group = "srv";
    };

    borgmatic.settings.sqlite_databases = [
      {
        name = "sonarr";
        path = "/srv/sonarr/sonarr.db";
      }
    ];

    caddy.virtualHosts."sonarr.fi33.buzz".extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };
}
