{
  config,
  ...
}:
let
  port = 5003;
  certloc = "/var/lib/acme/fi33.buzz";
in
{
  services = {
    radicale = {
      enable = true;
      settings = {
        server = {
          hosts = [
            "0.0.0.0:${toString port}"
            "[::]:${toString port}"
          ];
        };
        auth = {
          type = "htpasswd";
          htpasswd_filename = config.age.secrets.radicale.path;
          htpasswd_encryption = "plain";
        };
        storage = {
          filesystem_folder = "/srv/radicale";
        };
      };
    };

    caddy.virtualHosts."radicale.fi33.buzz".extraConfig = ''
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

  # secrets
  age.secrets."radicale" = {
    file = ../../../secrets/radicale.age;
    owner = "radicale";
  };
}
