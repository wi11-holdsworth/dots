{ config, lib, ... }:
let
  # declare the module name and its local module dependencies
  feature = "miniflux";
  dependencies = with config; [
    core
    nginx
    agenix
  ];
  port = "5010";

  # helper functions
  dependenciesEnabled = (lib.all (dep: dep.enable) dependencies);
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled && dependenciesEnabled;

in
{
  config = lib.mkIf enabled {
    age.secrets.miniflux-creds.file = ../../../secrets/miniflux-creds.age;

    services = {
      # service
      ${feature} = {
        enable = true;
        adminCredentialsFile = config.age.secrets.miniflux-creds.path;
        config = {
          BASE_URL = "https://miniflux.fi33.buzz";
          LISTEN_ADDR = "localhost:${port}";
        };
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
