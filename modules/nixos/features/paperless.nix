{
  config,
  ...
}:
let
  port = 5013;
  certloc = "/var/lib/acme/fi33.buzz";
in
{
  services = {
    paperless = {
      enable = true;
      dataDir = "/srv/paperless";
      database.createLocally = true;
      passwordFile = config.age.secrets.paperless.path;
      inherit port;
      settings = {
        PAPERLESS_URL = "https://paperless.fi33.buzz";
      };
    };

    borgmatic.settings = {
      postgresql_databases = [
        {
          name = "paperless";
          hostname = "localhost";
          username = "root";
          password = "{credential systemd borgmatic-pg}";
        }
      ];
    };

    caddy.virtualHosts."paperless.fi33.buzz".extraConfig = ''
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

  age.secrets."paperless" = {
    file = ../../../secrets/paperless.age;
    owner = "paperless";
  };
}
