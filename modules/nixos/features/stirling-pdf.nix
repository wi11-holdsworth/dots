{
  config,
  lib,
  ...
}:
let
  feature = "stirling-pdf";
  port = "5003";
in
{
  config = lib.mkIf config.${feature}.enable {
    services = {
      # service
      ${feature} = {
        enable = true;
        environment = {
          SERVER_PORT = lib.toInt port;
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
