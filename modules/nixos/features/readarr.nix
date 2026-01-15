let
  port = 5016;
  certloc = "/var/lib/acme/fi33.buzz";
in
{
  services = {
    readarr = {
      enable = true;
      dataDir = "/srv/readarr";
      settings.server = {
        inherit port;
      };
      group = "srv";
    };

    borgmatic.settings.sqlite_databases = [
      {
        name = "readarr";
        path = "/srv/readarr/readarr.db";
      }
    ];

    caddy.virtualHosts."readarr.fi33.buzz".extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };
}
