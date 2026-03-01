let
  port = 5012;
  certloc = "/var/lib/acme/fi33.buzz";
in
{
  services = {
    lidarr = {
      enable = true;
      dataDir = "/srv/lidarr";
      settings.server = {
        inherit port;
      };
      group = "srv";
    };

    caddy.virtualHosts."lidarr.fi33.buzz".extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };
}
