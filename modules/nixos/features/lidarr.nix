let
  port = 5012;
in
{
  services = {
    lidarr = {
      enable = true;
      dataDir = "/srv/lidarr";
      settings.server = {
        inherit port;
      };
      group = "srv";
    };

    nginx.virtualHosts."lidarr.fi33.buzz" = {
      forceSSL = true;
      useACMEHost = "fi33.buzz";
      locations."/".proxyPass = "http://localhost:${toString port}";
    };
  };
}
