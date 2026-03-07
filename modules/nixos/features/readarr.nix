let
  port = 5016;
  certloc = "/var/lib/acme/fi33.buzz";
  hostname = "books.fi33.buzz";
  url = "https://${hostname}";
in
{
  services = {
    readarr = {
      enable = true;
      dataDir = "/srv/readarr";
      settings.server = {
        inherit port;
      };
      group = "srv";
    };

    gatus.settings.endpoints = [
      {
        name = "Readarr";
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
