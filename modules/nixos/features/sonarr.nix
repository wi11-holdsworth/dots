let
  port = 5006;
  certloc = "/var/lib/acme/fi33.buzz";
in
{
  services = {
    sonarr = {
      enable = true;
      dataDir = "/srv/sonarr";
      settings.server = {
        inherit port;
      };
      group = "srv";
    };

    caddy.virtualHosts."sonarr.fi33.buzz".extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };
}
