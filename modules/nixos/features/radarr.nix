{
  config,
  lib,
  ...
}:
let
  feature = "radarr";
  port = "5007";
in
{
  config = lib.mkIf config.${feature}.enable {
    services = {
      # service
      radarr = {
        enable = true;
        dataDir = "/srv/radarr";
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
