{
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
      ROCKET_PORT="${port}";
      DOMAIN="https://${service}.fi33.buzz";
      SIGNUPS_ALLOWED = "false";
      INVITATIONS_ALLOWED = "false";
      SHOW_PASSWORD_HINT="false";
      USE_SYSLOG="true";
      EXTENDED_LOGGING="true";
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
}
