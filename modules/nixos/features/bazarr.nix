let
  port = 5017;
in
{
  services = {
    bazarr = {
      enable = true;
      dataDir = "/srv/bazarr";
      group = "media";
      listenPort = port;
    };

    nginx.virtualHosts."bazarr.fi33.buzz" = {
      forceSSL = true;
      useACMEHost = "fi33.buzz";
      locations."/".proxyPass = "http://localhost:${toString port}";
    };
  };
}
