let
  port = 8096;
in
{
  services = {
    jellyfin = {
      enable = true;
      dataDir = "/srv/jellyfin";
      group = "media";
    };

    nginx.virtualHosts."jellyfin.fi33.buzz" = {
      forceSSL = true;
      useACMEHost = "fi33.buzz";
      locations."/".proxyPass = "http://localhost:${toString port}";
    };
  };

  # use intel iGP
  systemd.services.jellyfin.environment.LIBVA_DRIVER_NAME = "iHD";
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
}
