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
      settings = {
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
}
