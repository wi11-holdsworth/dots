{
  config,
  lib,
  ...
}:
let
  feature = "paperless";
  port = "5013";
in
{
  config = lib.mkIf config.${feature}.enable {
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
