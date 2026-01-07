let
  port = 5005;
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

    nginx.virtualHosts."qbittorrent.fi33.buzz" = {
      forceSSL = true;
      useACMEHost = "fi33.buzz";
      locations."/".proxyPass = "http://localhost:${toString port}";
    };
  };
}
