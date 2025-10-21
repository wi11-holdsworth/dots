{
  lib,
  ...
}:
let
  port = "5007";
in
{
  services = {
    radarr = {
      enable = true;
      dataDir = "/srv/radarr";
      settings.server.port = lib.toInt port;
      group = "media";
    };

    nginx.virtualHosts."radarr.fi33.buzz" = {
      forceSSL = true;
      useACMEHost = "fi33.buzz";
      locations."/".proxyPass = "http://localhost:${port}";
    };
  };
}
