{
  config,
  inputs,
  lib,
  ...
}:
let
  # declare the module name and its local module dependencies
  feature = "vaultwarden";
  dependencies = with config; [
    agenix
    nginx
    core
  ];
  port = "5001";

  # helper functions
  dependenciesEnabled = (lib.all (dep: dep.enable) dependencies);
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled && dependenciesEnabled;

in
{
  config = lib.mkIf enabled {
    services.${feature} = {
      enable = true;
      backupDir = "/srv/${feature}";
      config = {
        rocketPort = "${port}";
        domain = "https://${feature}.fi33.buzz";
        signupsAllowed = false;
        invitationsAllowed = false;
        showPasswordHint = false;
        useSyslog = true;
        extendedLogging = true;
        adminTokenFile = "${config.age.secrets.vaultwarden-admin.path}";
      };
    };

    # reverse proxy
    services.nginx.virtualHosts."${feature}.fi33.buzz" = {
      forceSSL = true;
      useACMEHost = "fi33.buzz";
      locations."/" = {
        proxyPass = "http://localhost:${port}";
        proxyWebsockets = true;
      };
    };

    # secrets
    age.secrets = {
      "vaultwarden-admin" = {
        file = ../../../secrets/vaultwarden-admin.age;
        owner = "${feature}";
      };
    };
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
