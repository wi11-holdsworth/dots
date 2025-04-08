{ config, lib, ... }:
let
  # declare the module name and its local module dependencies
  feature = "feature";
  dependencies = with config; [ core nginx ];
  image = "image";
  port = "port";

  # helper functions
  dependenciesEnabled = (lib.all (dep: dep.enable) dependencies);
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled && dependenciesEnabled;

in {
  config = lib.mkIf enabled {
    virtualisation.oci-containers = {
      backend = "docker";

      containers.${feature} = {
        autoStart = true;

        inherit image;

        ports = [ "${port}:${port}" ];

        volumes = [ "/srv/${feature}:/data" ];
      };
    };

    # reverse proxy
    services.nginx.virtualHosts = {
      "${feature}.fi33.buzz" = {
        forceSSL = true;
        useACMEHost = "fi33.buzz";
        locations."/" = { proxyPass = "http://localhost:${port}"; };
      };
    };
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
