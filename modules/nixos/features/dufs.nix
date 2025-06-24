{ config, lib, ... }:
let
  # declare the module name and its local module dependencies
  feature = "dufs";
  dependencies = with config; [
    nginx
    core
  ];
  image = "sigoden/dufs";
  port = "5000";
  cfg = config.${feature};

  # helper functions
  dependenciesEnabled = (lib.all (dep: dep.enable) dependencies);
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled && dependenciesEnabled;

in
{
  config = lib.mkIf enabled {
    virtualisation.oci-containers = {
      backend = "docker";

      containers.${feature} = {
        autoStart = true;

        inherit image;

        ports = [ "${port}:${port}" ];

        volumes = [ "/srv/${feature}:/data" ];

        cmd = [
          "-a=admin:$6$j4cVhSXlBfnJb5LI$M9zzVmLtRQdJeGByy6GlS1XBxGljOe71mFjrxPibQKDV7kbByIVFa2oH7dwdgt6aEJZctKXx0pY/JHq0lULIG0@/:rw"
          "-A"
          "/data"
        ];
      };
    };

    # reverse proxy
    services.nginx.virtualHosts = {
      "${feature}.fi33.buzz" = {
        forceSSL = true;
        useACMEHost = "fi33.buzz";
        locations."/".proxyPass = "http://localhost:${port}";
      };
    };
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
