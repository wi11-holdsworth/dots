{
  config,
  ...
}:
let
  port = 5025;
  certloc = "/var/lib/acme/fi33.buzz";
  hostname = "status.fi33.buzz";
  url = "https://${hostname}";
in
{
  services = {
    gatus = {
      enable = true;
      environmentFile = config.age.secrets.gatus.path;
      settings = {
        alerting = {
          ntfy = {
            topic = "services";
            url = config.services.ntfy-sh.settings.base-url;
            token = "$NTFY_TOKEN";
            click = url;
            default-alert = {
              description = "Health Check Failed";
              send-on-resolved = true;
            };
          };
        };
        connectivity.checker = {
          target = "1.1.1.1:53";
          interval = "60s";
        };
        ui = {
          title = "Health Dashboard | Fi33Buzz";
          description = "Fi33Buzz health dashboard";
          dashboard-heading = "";
          dashboard-subheading = "";
          header = "Fi33Buzz Status";
          link = "https://home.fi33.buzz/";
          default-sort-by = "group";
        };
        web.port = port;
      };
    };

    caddy.virtualHosts.${hostname}.extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };

  age.secrets.gatus.file = ../../../secrets/gatus.age;
}
