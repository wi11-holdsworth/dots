{ config, lib, ... }:
let
  feature = "feature";
  image = "image";
  port = "port";
  cfg = config.${feature};

in {
  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";

  config = lib.mkIf cfg.enable {
    virtualisation.oci-containers = {
      backend = "docker";

      containers.${feature} = {
        autoStart = true;

        inherit image;

        ports = [ "${port}:${port}" ];

        volumes = [ "/srv/${feature}:/data" ];
      };
    };

    # reverse proxy
    services.nginx.virtualHosts = {
      "${feature}.fi33.buzz" = {
        forceSSL = true;
        useACMEHost = "fi33.buzz";
        locations."/" = { proxyPass = "http://localhost:${port}"; };
      };
    };
  };
}
