{
  config,
  lib,
  userName,
  ...
}:
let
  feature = "jellyfin";
  port = "8096";
in
{
  config = lib.mkIf config.${feature}.enable {
    services = {
      # service
      jellyfin = {
        enable = true;
        dataDir = "/srv/jellyfin";
        group = "media";
      };

      # reverse proxy
      nginx.virtualHosts."${feature}.fi33.buzz" = {
        forceSSL = true;
        useACMEHost = "fi33.buzz";
        locations."/".proxyPass = "http://localhost:${port}";
      };
    };

    # use intel iGP
    systemd.services.jellyfin.environment.LIBVA_DRIVER_NAME = "iHD";
    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
    };
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
