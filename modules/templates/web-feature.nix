let
  port = "port";
in
{
  services = {
    feature = {
      enable = true;
    };

    borgbackup.jobs = feature { };

    nginx.virtualHosts."feature.fi33.buzz" = {
      forceSSL = true;
      useACMEHost = "fi33.buzz";
      locations."/".proxyPass = "http://localhost:${port}";
    };
  };
}
