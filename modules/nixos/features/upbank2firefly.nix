{
  config,
  pkgs,
  ...
}:
let
  port = 5021;
  certloc = "/var/lib/acme/fi33.buzz";
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

  services.caddy.virtualHosts."upbank2firefly.fi33.buzz".extraConfig = ''
    reverse_proxy localhost:${toString port}
    tls ${certloc}/cert.pem ${certloc}/key.pem {
      protocols tls1.3
    }
  '';

  age.secrets.upbank2firefly.file = ../../../secrets/upbank2firefly.age;
}
