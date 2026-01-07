let
  port = 5016;
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

    nginx.virtualHosts."readarr.fi33.buzz" = {
      forceSSL = true;
      useACMEHost = "fi33.buzz";
      locations."/".proxyPass = "http://localhost:${toString port}";
    };
  };
}
