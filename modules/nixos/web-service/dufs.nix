{
  ...

}: let 
  service = "dufs";
  image = "sigoden/dufs";
  port = "5000";

in {

  virtualisation.oci-containers = {
    backend = "docker";

    containers.${service} = {
      autoStart = true;

      inherit image;
      
      ports = [
        "${port}:${port}"
      ];

      volumes = [
        "/srv/${service}:/data"
      ];
    };
  };

  # reverse proxy
  services.nginx.virtualHosts = {
    "${service}.fi33.buzz" = {
      forceSSL = true;
      useACMEHost = "fi33.buzz";
      locations."/" = {
        proxyPass = "http://localhost:${port}";
      };
    };
  };
}
