{ config, lib, ... }:
let
  feature = "dufs";
  image = "sigoden/dufs";
  port = "5000";
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

        cmd = [ "-A" "/data" ];
      };
    };

    # reverse proxy
    services.nginx.virtualHosts = {
      "${feature}.fi33.buzz" = {
        forceSSL = true;
        useACMEHost = "fi33.buzz";
        locations."/".proxyPass = "http://localhost:${port}";
      };
    };
  };
}
