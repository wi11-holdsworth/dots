{ config, inputs, lib, ... }:
let
  feature = "vaultwarden";
  port = "5001";
  cfg = config.${feature};

in {
  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";

  config = lib.mkIf cfg.enable {
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
      "api-mailjet" = {
        file = ../../../secrets/api-mailjet.age;
        owner = "${feature}";
      };
      "secret-mailjet" = {
        file = ../../../secrets/secret-mailjet.age;
        owner = "${feature}";
      };
      "vaultwarden-admin" = {
        file = ../../../secrets/vaultwarden-admin.age;
        owner = "${feature}";
      };
    };
  };
}
