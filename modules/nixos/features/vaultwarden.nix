{
  config,
  lib,
  ...
}:
let
  feature = "vaultwarden";
  port = "5001";
in
{
  config = lib.mkIf config.${feature}.enable {
    services = {
      vaultwarden = {
        enable = true;
        backupDir = "/srv/vaultwarden";
        config = {
          rocketPort = "${port}";
          domain = "https://vaultwarden.fi33.buzz";
          signupsAllowed = false;
          invitationsAllowed = false;
          showPasswordHint = false;
          useSyslog = true;
          extendedLogging = true;
          adminTokenFile = "${config.age.secrets.vaultwarden-admin.path}";
        };
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
    age.secrets."vaultwarden-admin" = {
      file = ../../../secrets/vaultwarden-admin.age;
      owner = "vaultwarden";
    };
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
