let
  port = 5009;
  certloc = "/var/lib/acme/fi33.buzz";
in
{
  services = {
    prowlarr = {
      enable = true;
      dataDir = "/srv/prowlarr";
      settings.server = {
        inherit port;
      };
    };

    caddy.virtualHosts."prowlarr.fi33.buzz".extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };
}
