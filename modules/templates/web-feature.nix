{
  config,
  lib,
  ...
}:
let
  feature = "replace";
  port = "port";
in
{
  config = lib.mkIf config.${feature}.enable {
    services = {
      # service
      replace = {
        enable = true;
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
