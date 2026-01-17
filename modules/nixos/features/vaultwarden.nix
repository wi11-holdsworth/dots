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

    borgmatic.settings.sqlite_databases = [
      {
        name = "vaultwarden";
        path = "/srv/vaultwarden/db.sqlite3";
      }
    ];

    caddy.virtualHosts."vaultwarden.fi33.buzz".extraConfig = ''
      forward_auth unix//run/tailscale-nginx-auth/tailscale-nginx-auth.sock {
        uri /auth
        header_up Remote-Addr {remote_host}
        header_up Remote-Port {remote_port}
        header_up Original-URI {uri}
        copy_headers {
          Tailscale-User>X-Webauth-User
          Tailscale-Name>X-Webauth-Name
          Tailscale-Login>X-Webauth-Login
          Tailscale-Tailnet>X-Webauth-Tailnet
          Tailscale-Profile-Picture>X-Webauth-Profile-Picture
        }
      }
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
