let
  port = "port";
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

    nginx.virtualHosts."feature.fi33.buzz" = {
      forceSSL = true;
      useACMEHost = "fi33.buzz";
      locations."/".proxyPass = "http://localhost:${port}";
    };
  };
}
