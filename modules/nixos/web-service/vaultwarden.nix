{
  config,
  ...

}: let 
  service = "vaultwarden";
  port = "5001";

in {

  # service
  services.${service} = {
    enable = true;
    backupDir = "/srv/${service}";
    config = {
      rocketPort = "${port}";
      domain = "https://${service}.fi33.buzz";
      signupsAllowed = false;
      invitationsAllowed = false;
      showPasswordHint = false;
      useSyslog = true;
      extendedLogging = true;
      adminTokenFile = "${config.age.secrets.vaultwarden-admin.path}";
      smtpHost = "in-v3.mailjet.com";
      smtpFrom = "admin@fi33.buzz";
      smtpPort = 587;
      smtpSecurity = "starttls";
      smtpAuthMechanism = "Login";
      smtpUsernameFile = "${config.age.secrets.api-mailjet.path}";
      smtpPasswordFile = "${config.age.secrets.secret-mailjet.path}";
    };
  };


  # reverse proxy
  services.nginx.virtualHosts = {
    "${service}.fi33.buzz" = {
      forceSSL = true;
      useACMEHost = "fi33.buzz";
      locations."/" = {
        proxyPass = "http://localhost:${port}";
        proxyWebsockets = true;
      };
    };
  };

  # secrets
  age.secrets = {
    "api-mailjet" = {
      file = ../../../secrets/api-mailjet.age; 
      owner = "${service}";
    };
    "secret-mailjet" = {
      file = ../../../secrets/secret-mailjet.age; 
      owner = "${service}";
    };
    "vaultwarden-admin" = {
      file = ../../../secrets/vaultwarden-admin.age; 
      owner = "${service}";
    };
  };
}
