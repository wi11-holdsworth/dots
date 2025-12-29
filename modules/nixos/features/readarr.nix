let
  port = 5016;
in
{
  services = {
    readarr = {
      enable = true;
      dataDir = "/srv/readarr";
      settings.server = {
        inherit port;
      };
      group = "media";
    };

    # borgmatic.settings = {
    #   source_directories = [ ];
    #   postgresql_databases = [
    #     {
    #       name = "readarr";
    #       hostname = "localhost";
    #       username = "root";
    #       password = "{credential systemd borgmatic-pg}";
    #     }
    #   ];
    # };

    nginx.virtualHosts."readarr.fi33.buzz" = {
      forceSSL = true;
      useACMEHost = "fi33.buzz";
      locations."/".proxyPass = "http://localhost:${toString port}";
    };
  };
}
