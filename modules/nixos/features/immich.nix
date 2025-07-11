{
  config,
  lib,
  ...
}:
let
  feature = "immich";
  port = "2283";
in
{
  config = lib.mkIf config.${feature}.enable {
    services.${feature} = {
      enable = true;
      port = builtins.fromJSON "${port}";
      mediaLocation = "/srv/${feature}";
    };

    # reverse proxy
    services.nginx = {
      clientMaxBodySize = "50000M";

      virtualHosts."${feature}.fi33.buzz" = {
        forceSSL = true;
        useACMEHost = "fi33.buzz";
        locations."/" = {
          proxyPass = "http://[::1]:${port}";
          proxyWebsockets = true;
        };
      };
    };
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
