{
  config,
  lib,
  ...
}:
let
  feature = "ntfy-sh";
  port = "5002";
in
{
  config = lib.mkIf config.${feature}.enable {
    services = {
      # service
      ${feature} = {
        enable = true;
        settings = {
          base-url = "https://${feature}.fi33.buzz";
          listen-http = ":${port}";
          behind-proxy = true;
        };
      };

      # reverse proxy
      nginx = {
        virtualHosts."${feature}.fi33.buzz" = {
          forceSSL = true;
          useACMEHost = "fi33.buzz";
          locations."/" = {
            proxyPass = "http://localhost:${port}";
            proxyWebsockets = true;
          };
        };
      };
    };
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
