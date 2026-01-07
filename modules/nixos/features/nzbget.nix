let
  port = 5018;
in
{
  services = {
    nzbget = {
      enable = true;
      settings = {
        MainDir = "/srv/nzbget";
        ControlPort = port;
      };
      group = "srv";
    };

    nginx.virtualHosts."nzbget.fi33.buzz" = {
      forceSSL = true;
      useACMEHost = "fi33.buzz";
      locations."/".proxyPass = "http://localhost:${toString port}";
    };
  };
}
