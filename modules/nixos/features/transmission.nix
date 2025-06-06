{
  config,
  lib,
  pkgs,
  ...
}:
let
  # declare the module name and its local module dependencies
  feature = "transmission";
  dependencies = with config; [
    core
    nginx
  ];
  port = "5008";

  # helper functions
  dependenciesEnabled = (lib.all (dep: dep.enable) dependencies);
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled && dependenciesEnabled;

in
{
  config = lib.mkIf enabled {
    services = {
      transmission = {
        enable = true;
        package = pkgs.transmission_4;
        settings = {
          download-dir = "/media/Downloads";
          rpc-host-whitelist-enabled = false;
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
