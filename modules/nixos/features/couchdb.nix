{ config, lib, ... }:
let
  # declare the module name and its local module dependencies
  feature = "couchdb";
  dependencies = with config; [ core nginx ];
  port = "5984";

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
        databaseDir = "/srv/couchdb";
        viewIndexDir = "/srv/couchdb";
        configFile = "/srv/couchdb";
        port = lib.toInt port;
        extraConfig = {
          chttpd = {
            require_valid_user = true;
            enable_cors = true;
            max_http_request_size = 4294967296;
          };

          chttpd_auth.require_valid_user = true;

          httpd = {
            WWW-Authenticate = ''Basic realm="couchdb"'';
            enable_cors = true;
          };

          couchdb.max_document_size = 50000000;

          cors = {
            credentials = true;
            origins = ''
              app://obsidian.md,capacitor://localhost,http://localhost,https://localhost,capacitor://couchdb.fi33.buzz,http://couchdb.fi33.buzz,https://couchdb.fi33.buzz
            '';
          };
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
