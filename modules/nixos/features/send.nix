let
  port = 5020;
  certloc = "/var/lib/acme/fi33.buzz";
  hostname = "send.fi33.buzz";
  url = "https://${hostname}";
in
{
  services = {
    send = {
      enable = true;
      inherit port;
      baseUrl = url;
      environment = {
        DEFAULT_EXPIRE_SECONDS = 360;
        EXPIRE_TIMES_SECONDS = "360";
        DOWNLOAD_COUNTS = "1";
        MAX_DOWNLOADS = 1;
        MAX_EXPIRE_SECONDS = 1024;
        MAX_FILE_SIZE = 134217728;
      };
    };

    gatus.settings.endpoints = [
      {
        name = "Send";
        group = "Public Services";
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
