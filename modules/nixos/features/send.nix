let
  port = 5020;
  certloc = "/var/lib/acme/fi33.buzz";
in
{
  services = {
    send = {
      enable = true;
      inherit port;
      baseUrl = "https://send.fi33.buzz";
      environment = {
        DEFAULT_EXPIRE_SECONDS = 360;
        EXPIRE_TIMES_SECONDS = "360";
        DOWNLOAD_COUNTS = "1";
        MAX_DOWNLOADS = 1;
        MAX_EXPIRE_SECONDS = 1024;
        MAX_FILE_SIZE = 134217728;
      };
    };

    caddy.virtualHosts."send.fi33.buzz".extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };
}
