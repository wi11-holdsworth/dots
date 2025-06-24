{ config, lib, ... }:
let
  # declare the module name and its local module dependencies
  feature = "paperless";
  dependencies = with config; [
    agenix
    core
    nginx
  ];
  port = "5013";

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
        dataDir = "/srv/paperless";
        database.createLocally = true;
        passwordFile = config.age.secrets.paperless.path;
        port = lib.toInt port;
        settings = {
          PAPERLESS_URL = "https://paperless.fi33.buzz";
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

    age.secrets.paperless.file = ../../../secrets/paperless.age;
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
