let
  port = 5009;
in
{
  services = {
    prowlarr = {
      enable = true;
      dataDir = "/srv/prowlarr";
      settings.server = {
        inherit port;
      };
    };

    nginx = {
      virtualHosts."prowlarr.fi33.buzz" = {
        forceSSL = true;
        useACMEHost = "fi33.buzz";
        locations."/".proxyPass = "http://localhost:${toString port}";
      };
    };
  };
}
