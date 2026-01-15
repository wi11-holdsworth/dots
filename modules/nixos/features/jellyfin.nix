let
  port = 8096;
  certloc = "/var/lib/acme/fi33.buzz";
in
{
  services = {
    jellyfin = {
      enable = true;
      dataDir = "/srv/jellyfin";
      group = "srv";
    };

    borgmatic.settings.sqlite_databases = [
      {
        name = "jellyfin";
        path = "/srv/jellyfin/data/jellyfin.db";
      }
    ];

    caddy.virtualHosts."jellyfin.fi33.buzz".extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };

  # use intel iGP
  systemd.services.jellyfin.environment.LIBVA_DRIVER_NAME = "iHD";
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
}
