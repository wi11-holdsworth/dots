{ config, lib, ... }:
let
  # declare the module name and its local module dependencies
  feature = "lidarr";
  dependencies = with config; [
    core
    nginx
  ];
  port = "5012";

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
