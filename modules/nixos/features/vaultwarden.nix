{
  config,
  ...
}:
let
  port = 5001;
  certloc = "/var/lib/acme/fi33.buzz";
in
{
  services = {
    vaultwarden = {
      enable = true;
      backupDir = "/srv/vaultwarden";
      config = {
        rocketPort = toString port;
        domain = "https://vaultwarden.fi33.buzz";
        signupsAllowed = false;
        invitationsAllowed = false;
        showPasswordHint = false;
        useSyslog = true;
        extendedLogging = true;
        adminTokenFile = "${config.age.secrets.vaultwarden-admin.path}";
      };
    };

    caddy.virtualHosts."vaultwarden.fi33.buzz".extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };

  age.secrets."vaultwarden-admin" = {
    file = ../../../secrets/vaultwarden-admin.age;
    owner = "vaultwarden";
  };
}
