{
  ...

}: let 
  service = "jellyfin";
  port = "8096";

in {
  services = {
    # service
    ${service} = {
      enable = true;
      dataDir = "/srv/jellyfin";
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
