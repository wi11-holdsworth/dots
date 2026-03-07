let
  port = 5005;
  certloc = "/var/lib/acme/fi33.buzz";
  hostname = "bittorrent.fi33.buzz";
  url = "https://${hostname}";
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

    gatus.settings.endpoints = [
      {
        name = "qBittorrent";
        group = "Media Management";
        inherit url;
        interval = "5m";
        conditions = [
          "[STATUS] == 200"
          "[CONNECTED] == true"
          "[RESPONSE_TIME] < 500"
        ];
        alerts = [ { type = "ntfy"; } ];
      }
    ];

    caddy.virtualHosts.${hostname}.extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };
}
