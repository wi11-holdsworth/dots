{ config, lib, ... }:
let
  # declare the module name and its local module dependencies
  feature = "freshrss";
  dependencies = with config; [ core nginx ];
  port = "port";

  # helper functions
  dependenciesEnabled = (lib.all (dep: dep.enable) dependencies);
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled && dependenciesEnabled;

in {
  config = lib.mkIf enabled {
    services = {
      # service
      ${feature} = { 
        enable = true; 

        authType = "none";
        baseUrl = "https://freshrss.fi33.buzz";
        dataDir = "/srv/freshrss";
      };
    };
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
