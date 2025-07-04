{ config, lib, ... }:
let
  # declare the module name and its local module dependencies
  feature = "webdav";
  dependencies = with config; [
    core
    nginx
  ];
  port = "5000";

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
          address = "127.0.0.1";
          port = lib.toInt port;
          permissions = "R";
          directory = "/srv/webdav";
          modify = true;
          users = [
            {
              username = "admin";
              password = "{bcrypt}$2a$10$Buai6WtOhE7NoSNKNzcJ1OEJNFWyUzp6Y6b8i9pvdvIFNw8OaxCGm";
              permissions = "CRUD";
            }
          ];
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
