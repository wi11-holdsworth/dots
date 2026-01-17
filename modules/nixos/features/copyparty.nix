{
  # keep-sorted start
  config,
  inputs,
  # keep-sorted end
  ...
}:
let
  port = 5000;
  certloc = "/var/lib/acme/fi33.buzz";
in
{
  imports = [ inputs.copyparty.nixosModules.default ];

  services = {
    copyparty = {
      enable = true;
      settings = {
        z = true;
        e2dsa = true;
        e2ts = true;
        e2vu = true;
        p = port;
      };

      accounts.will.passwordFile = config.age.secrets.copyparty-will.path;

      volumes."/" = {
        path = "/srv/copyparty";
        access = {
          r = "*";
          A = [ "will" ];
        };
      };
    };

    caddy.virtualHosts."copyparty.fi33.buzz".extraConfig = ''
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
  age.secrets."copyparty-will" = {
    file = ../../../secrets/copyparty-will.age;
    owner = "copyparty";
  };

  nixpkgs.overlays = [ inputs.copyparty.overlays.default ];
}
