{
  config,
  lib,
  userName,
  ...
}:
let
  # declare the module name and its local module dependencies
  feature = "jellyfin";
  dependencies = with config; [
    nginx
    core
  ];
  port = "8096";

  # helper functions
  dependenciesEnabled = (lib.all (dep: dep.enable) dependencies);
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled && dependenciesEnabled;

in
{
  config = lib.mkIf enabled {
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

    users.users.${userName}.extraGroups = [ "jellyfin" ];
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
