let
  port = 8096;
  certloc = "/var/lib/acme/fi33.buzz";
in
{
  services = {
    jellyfin = {
      enable = true;
      dataDir = "/srv/jellyfin";
      group = "srv";
    };

    borgmatic.settings.sqlite_databases = [
      {
        name = "jellyfin";
        path = "/srv/jellyfin/data/jellyfin.db";
      }
    ];

    caddy.virtualHosts."jellyfin.fi33.buzz".extraConfig = ''
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

  # use intel iGP
  systemd.services.jellyfin.environment.LIBVA_DRIVER_NAME = "iHD";
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
}
