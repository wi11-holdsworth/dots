let
  port = 8096;
  certloc = "/var/lib/acme/fi33.buzz";
  hostname = "media.fi33.buzz";
  url = "https://${hostname}";
in
{
  services = {
    jellyfin = {
      enable = true;
      dataDir = "/srv/jellyfin";
      group = "srv";
    };

    gatus.settings.endpoints = [
      {
        name = "Jellyfin";
        group = "Media Streaming";
        inherit url;
        interval = "5m";
        conditions = [
          "[STATUS] == 200"
          "[CONNECTED] == true"
          "[RESPONSE_TIME] < 500"
        ];
        alerts = [ { type = "ntfy"; } ];
      }
    ];

    caddy.virtualHosts.${hostname}.extraConfig = ''
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
