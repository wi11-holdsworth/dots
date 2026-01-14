{
  config,
  pkgs,
  ...
}:
let
  port = 5021;
in
{
  virtualisation.oci-containers = {
    backend = "docker";
    containers.upbank2firefly = {
      extraOptions = [
        "--network=host"
      ];
      image = "compose2nix/upbank2firefly";
      environment = {
        FIREFLY_BASEURL = "https://firefly.fi33.buzz";
        TZ = "Australia/Melbourne";
      };
      environmentFiles = [ config.age.secrets.upbank2firefly.path ];
      volumes = [
        "/srv/upbank2firefly/app:/app:rw"
      ];
      ports = [
        "${toString port}:80/tcp"
      ];
    };
  };

  systemd = {
    services = {
      "docker-build-upbank2firefly" = {
        path = with pkgs; [
          docker
          git
        ];
        serviceConfig = {
          Type = "oneshot";
          TimeoutSec = 300;
        };
        script = ''
          cd /srv/upbank2firefly
          git pull
          docker build -t compose2nix/upbank2firefly .
        '';
      };
    };
  };

  services.nginx.virtualHosts."upbank2firefly.fi33.buzz" = {
    forceSSL = true;
    useACMEHost = "fi33.buzz";
    locations."/".proxyPass = "http://localhost:${toString port}";
  };

  age.secrets.upbank2firefly.file = ../../../secrets/upbank2firefly.age;
}
