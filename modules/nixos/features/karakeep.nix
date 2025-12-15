let
  port = "5014";
in
{
  services = {
    karakeep = {
      enable = true;
      extraEnvironment = {
        PORT = port;
        DISABLE_NEW_RELEASE_CHECK = "true";
      };
    };

    nginx.virtualHosts."karakeep.fi33.buzz" = {
      forceSSL = true;
      useACMEHost = "fi33.buzz";
      locations."/".proxyPass = "http://localhost:${port}";
    };
  };
}
