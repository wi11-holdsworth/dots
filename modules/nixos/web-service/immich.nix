{
  ...

}: let 
  service = "immich";
  port = "2283";

in {

  # service
  services.${service} = {
    enable = true;
    port = builtins.fromJSON "${port}";
    mediaLocation = "/srv/${service}";
  };


  # reverse proxy
  services.nginx = {
    clientMaxBodySize = "50000M";

    virtualHosts."${service}.fi33.buzz" = {
      forceSSL = true;
      useACMEHost = "fi33.buzz";
      locations."/" = {
        proxyPass = "http://[::1]:${port}";
        proxyWebsockets = true;
      };
    };
  };
}
