{ config, lib, ... }:
let
  # declare the module name and its local module dependencies
  feature = "sonarr";
  dependencies = with config; [
    core
    nginx
    jellyfin
  ];
  port = "5006";

  # helper functions
  dependenciesEnabled = (lib.all (dep: dep.enable) dependencies);
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled && dependenciesEnabled;

in
{
  config = lib.mkIf enabled {
    services = {
      # service
      ${feature} = {
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
