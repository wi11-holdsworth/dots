{ config, lib, ... }:
let
  feature = "immich";
  port = "2283";
  cfg = config.${feature};

in {
  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";

  config = lib.mkIf cfg.enable {
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
}
