{ config, lib, ... }:
let
  # declare the module name and its local module dependencies
  feature = "immich";
  dependencies = with config; [ age nginx core ];
  port = "2283";

  # helper functions
  dependenciesEnabled = (lib.all (dep: dep.enable) dependencies);
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled && dependenciesEnabled;

in {
  config = lib.mkIf enabled {
    services.${feature} = {
      enable = true;
      port = builtins.fromJSON "${port}";
      mediaLocation = "/srv/${feature}";
    };

    # reverse proxy
    services.nginx = {
      clientMaxBodySize = "50000M";

      virtualHosts."${feature}.fi33.buzz" = {
        forceSSL = true;
        useACMEHost = "fi33.buzz";
        locations."/" = {
          proxyPass = "http://[::1]:${port}";
          proxyWebsockets = true;
        };
      };
    };
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
