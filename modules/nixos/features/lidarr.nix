{
  config,
  lib,
  ...
}:
let
  feature = "lidarr";
  port = "5012";
in
{
  config = lib.mkIf config.${feature}.enable {
    services = {
      # service
      lidarr = {
        enable = true;
        dataDir = "/srv/lidarr";
        settings.server.port = lib.toInt port;
        group = "media";
      };

      # reverse proxy
      nginx = {
        virtualHosts."${feature}.fi33.buzz" = {
          forceSSL = true;
          useACMEHost = "fi33.buzz";
          locations."/" = {
            proxyPass = "http://localhost:${port}";
            # proxyWebsockets = true;
          };
        };
      };
    };
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
