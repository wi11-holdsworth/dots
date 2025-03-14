{
  ...

}: let 
  service = "glances";
  port = "61208";

in {
  services = {
    # service
    ${service} = {
      enable = true;
    };

    # reverse proxy
    nginx = {
      virtualHosts."${service}.fi33.buzz" = {
        forceSSL = true;
        useACMEHost = "fi33.buzz";
        locations."/" = {
          proxyPass = "http://localhost:${port}";
          # proxyWebsockets = true;
        };
      };
    };
  };
 }
