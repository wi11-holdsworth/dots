{
  # keep-sorted start
  lib,
  pkgs,
  # keep-sorted end
  ...
}:
let
  port = 5019;
  certloc = "/var/lib/acme/fi33.buzz";
in
{
  environment.systemPackages = [ pkgs.qui ];

  systemd.user.services.qui = {
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig.ExecStart = "${lib.getExe pkgs.qui} serve";

    environment = {
      QUI__PORT = toString port;
      QUI__DATA_DIR = "/srv/qui";
    };
  };

  services.borgmatic.settings.sqlite_databases = [
    {
      name = "qui";
      path = "/srv/qui/qui.db";
    }
  ];

  services.caddy.virtualHosts."qui.fi33.buzz".extraConfig = ''
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
}
