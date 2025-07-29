{
  config,
  lib,
  ...
}:
let
  feature = "miniflux";
  port = "5010";
in
{
  config = lib.mkIf config.${feature}.enable {
    services = {
      # service
      miniflux = {
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

    # secrets
    age.secrets."miniflux-creds".file = ../../../secrets/miniflux-creds.age;

  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
