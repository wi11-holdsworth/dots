let
  port = 5005;
  certloc = "/var/lib/acme/fi33.buzz";
in
{
  services = {
    qbittorrent = {
      enable = true;
      webuiPort = port;
      profileDir = "/srv";
      group = "srv";
      extraArgs = [
        "--confirm-legal-notice"
      ];
    };

    caddy.virtualHosts."qbittorrent.fi33.buzz".extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };
}
