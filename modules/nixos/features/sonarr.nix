{
  config,
  lib,
  ...
}:
let
  feature = "sonarr";
  port = "5006";
in
{
  config = lib.mkIf config.${feature}.enable {
    services = {
      # service
      sonarr = {
        enable = true;
        dataDir = "/srv/sonarr";
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
