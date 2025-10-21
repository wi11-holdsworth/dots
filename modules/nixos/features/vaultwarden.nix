{
  config,
  ...
}:
let
  port = "5001";
in
{
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

    nginx.virtualHosts."vaultwarden.fi33.buzz" = {
      forceSSL = true;
      useACMEHost = "fi33.buzz";
      locations."/" = {
        proxyPass = "http://localhost:${port}";
        proxyWebsockets = true;
      };
    };
  };

  age.secrets."vaultwarden-admin" = {
    file = ../../../secrets/vaultwarden-admin.age;
    owner = "vaultwarden";
  };
}
