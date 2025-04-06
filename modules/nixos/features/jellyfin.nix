{ config, lib, ... }:
let
  feature = "jellyfin";
  port = "8096";
  cfg = config.${feature};

in {
  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";

  config = lib.mkIf cfg.enable {
    services = {
      # service
      ${feature} = {
        enable = true;
        dataDir = "/srv/jellyfin";
      };

      # reverse proxy
      nginx.virtualHosts."${feature}.fi33.buzz" = {
        forceSSL = true;
        useACMEHost = "fi33.buzz";
        locations."/".proxyPass = "http://localhost:${port}";
      };
    };
  };
}
