{ config, lib, ... }:
let
  # declare the module name and its local module dependencies
  feature = "ntfy-sh";
  dependencies = with config; [
    core
    nginx
  ];
  port = "5002";

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
        settings = {
          base-url = "https://${feature}.fi33.buzz";
          listen-http = ":${port}";
          behind-proxy = true;
        };
      };

      # reverse proxy
      nginx = {
        virtualHosts."${feature}.fi33.buzz" = {
          forceSSL = true;
          useACMEHost = "fi33.buzz";
          locations."/" = {
            proxyPass = "http://localhost:${port}";
            proxyWebsockets = true;
          };
        };
      };
    };
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
