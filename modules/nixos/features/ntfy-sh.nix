let
  port = "5002";
in
{
  services = {
    ntfy-sh = {
      enable = true;
      settings = {
        base-url = "https://ntfy-sh.fi33.buzz";
        listen-http = ":${port}";
        behind-proxy = true;
      };
    };

    nginx.virtualHosts."ntfy-sh.fi33.buzz" = {
      forceSSL = true;
      useACMEHost = "fi33.buzz";
      locations."/" = {
        proxyPass = "http://localhost:${port}";
        proxyWebsockets = true;
      };
    };
  };
}
