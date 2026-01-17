{
  config,
  ...
}:
let
  port = 5010;
  certloc = "/var/lib/acme/fi33.buzz";
in
{
  services = {
    miniflux = {
      enable = true;
      adminCredentialsFile = config.age.secrets.miniflux-creds.path;
      config = {
        BASE_URL = "https://miniflux.fi33.buzz";
        LISTEN_ADDR = "localhost:${toString port}";
      };
    };

    borgmatic.settings.postgresql_databases = [
      {
        name = "miniflux";
        hostname = "localhost";
        username = "root";
        password = "{credential systemd borgmatic-pg}";
      }
    ];

    caddy.virtualHosts."miniflux.fi33.buzz".extraConfig = ''
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

  age.secrets."miniflux-creds".file = ../../../secrets/miniflux-creds.age;
}
