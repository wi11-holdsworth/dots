{
  config,
  ...
}:
let
  port = 5013;
  certloc = "/var/lib/acme/fi33.buzz";
  hostname = "documents.fi33.buzz";
  url = "https://${hostname}";
in
{
  services = {
    paperless = {
      enable = true;
      dataDir = "/srv/paperless";
      database.createLocally = true;
      passwordFile = config.age.secrets.paperless.path;
      inherit port;
      settings = {
        PAPERLESS_URL = url;
      };
    };

    gatus.settings.endpoints = [
      {
        name = "Paperless";
        group = "Media Streaming";
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

  age.secrets."paperless" = {
    file = ../../../secrets/paperless.age;
    owner = "paperless";
  };
}
