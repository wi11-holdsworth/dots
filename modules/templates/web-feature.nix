let
  port = 0000;
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
      locations."/".proxyPass = "http://localhost:${toString port}";
    };
  };
}
