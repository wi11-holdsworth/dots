{
  config,
  lib,
  pkgs,
  ...
}:
let
  feature = "transmission";
  port = "5008";
in
{
  config = lib.mkIf config.${feature}.enable {
    services = {
      transmission = {
        enable = true;
        package = pkgs.transmission_4;
        settings = {
          download-dir = "/media/Downloads";
          rpc-host-whitelist-config.${feature}.enable = false;
          rpc-port = lib.toInt port;
          rpc-whitelist-enable = false;
        };
        group = "media";
        webHome = pkgs.flood-for-transmission;
      };

      # reverse proxy
      nginx.virtualHosts."${feature}.fi33.buzz" = {
        forceSSL = true;
        useACMEHost = "fi33.buzz";
        locations."/".proxyPass = "http://localhost:${port}";
      };
    };
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
