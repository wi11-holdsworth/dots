let
  port = 5006;
in
{
  services = {
    sonarr = {
      enable = true;
      dataDir = "/srv/sonarr";
      settings.server = {
        inherit port;
      };
      group = "media";
    };

    nginx.virtualHosts."sonarr.fi33.buzz" = {
      forceSSL = true;
      useACMEHost = "fi33.buzz";
      locations."/".proxyPass = "http://localhost:${toString port}";
    };
  };
}
