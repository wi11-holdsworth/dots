{
  ...

}: let 
  service = "service";
  image = "image";
  port = "port";

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
