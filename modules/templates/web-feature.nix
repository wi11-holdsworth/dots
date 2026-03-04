let
  port = 0000;
  certloc = "/var/lib/acme/fi33.buzz";
  hostname = "feature.fi33.buzz";
  url = "https://${hostname}";
in
{
  services = {
    feature = {
      enable = true;
    };

    # borgmatic.settings = {
    #   source_directories = [ ];
    #   postgresql_databases = [
    #     {
    #       name = "feature";
    #       hostname = "localhost";
    #       username = "root";
    #       password = "{credential systemd borgmatic-pg}";
    #     }
    #   ];
    # };

    caddy.virtualHosts.${hostname}.extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };
}
