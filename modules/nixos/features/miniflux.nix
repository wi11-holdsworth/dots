{
  config,
  ...
}:
let
  port = 5010;
  certloc = "/var/lib/acme/fi33.buzz";
  hostname = "feeds.fi33.buzz";
  url = "https://${hostname}";
in
{
  services = {
    miniflux = {
      enable = true;
      adminCredentialsFile = config.age.secrets.miniflux-creds.path;
      config = {
        BASE_URL = url;
        LISTEN_ADDR = "localhost:${toString port}";
      };
    };

    gatus.settings.endpoints = [
      {
        name = "Miniflux";
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

  age.secrets."miniflux-creds".file = ../../../secrets/miniflux-creds.age;
}
