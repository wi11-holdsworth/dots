{ config, lib, ... }:
let
  feature = "radicale";
  port = "5003";
in
{
  config = lib.mkIf config.${feature}.enable {
    services = {
      # service
      radicale = {
        enable = true;
        settings = {
          server = {
            hosts = [
              "0.0.0.0:${port}"
              "[::]:${port}"
            ];
          };
          auth = {
            type = "htpasswd";
            htpasswd_filename = config.age.secrets."radicale".path;
            htpasswd_encryption = "plain";
          };
          storage = {
            filesystem_folder = "/srv/radicale";
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

    age.secrets."radicale" = {
      file = ../../../secrets/radicale.age;
      owner = "radicale";
    };
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
