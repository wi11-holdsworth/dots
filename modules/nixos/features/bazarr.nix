let
  port = 5017;
  certloc = "/var/lib/acme/fi33.buzz";
  hostname = "subtitles.fi33.buzz";
  url = "https://${hostname}";
in
{
  services = {
    bazarr = {
      enable = true;
      dataDir = "/srv/bazarr";
      group = "srv";
      listenPort = port;
    };

    gatus.settings.endpoints = [
      {
        name = "Bazarr";
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
