{
  config,
  ...
}:
let
  port = 5001;
  certloc = "/var/lib/acme/fi33.buzz";
  hostname = "vault.fi33.buzz";
  url = "https://${hostname}";
in
{
  services = {
    vaultwarden = {
      enable = true;
      backupDir = "/srv/vaultwarden";
      config = {
        rocketPort = toString port;
        domain = url;
        signupsAllowed = false;
        invitationsAllowed = false;
        showPasswordHint = false;
        useSyslog = true;
        extendedLogging = true;
        adminTokenFile = "${config.age.secrets.vaultwarden-admin.path}";
      };
    };

    gatus.settings.endpoints = [
      {
        name = "Vaultwarden";
        group = "Private Services";
        inherit url;
        interval = "5m";
        conditions = [
          "[STATUS] == 200"
          "[CONNECTED] == true"
          "[RESPONSE_TIME] < 500"
        ];
      }
    ];

    caddy.virtualHosts.${hostname}.extraConfig = ''
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
