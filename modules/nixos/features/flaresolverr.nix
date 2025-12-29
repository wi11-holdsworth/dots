let
  port = 5011;
in
{
  services = {
    flaresolverr = {
      enable = true;
      inherit port;
    };

    nginx.virtualHosts."flaresolverr.fi33.buzz" = {
      forceSSL = true;
      useACMEHost = "fi33.buzz";
      locations."/".proxyPass = "http://localhost:${toString port}";
    };
  };
}
