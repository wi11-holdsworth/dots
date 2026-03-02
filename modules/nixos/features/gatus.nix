let
  port = 5025;
  certloc = "/var/lib/acme/fi33.buzz";
in
{
  services = {
    gatus = {
      enable = true;
      settings = {
        web = {
          inherit port;
        };
        endpoints = [
          {
            name = "website";
            url = "https://twin.sh/health";
            interval = "5m";
            conditions = [
              "[STATUS] == 200"
              "[BODY].status == UP"
              "[RESPONSE_TIME] < 300"
            ];
          }
        ];
      };
    };

    # borgmatic.settings = {
    #   source_directories = [ ];
    #   postgresql_databases = [
    #     {
    #       name = "gatus";
    #       hostname = "localhost";
    #       username = "root";
    #       password = "{credential systemd borgmatic-pg}";
    #     }
    #   ];
    # };

    caddy.virtualHosts."uptime.fi33.buzz".extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };
}
