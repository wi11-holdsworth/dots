{
  services = {
    ddns-updater = {
      enable = true;
      environment = {
        CONFIG_FILEPATH = "/srv/ddns-updater/config.json";
        SERVER_ENABLED = "no";
        TZ = "Australia/Melbourne";
      };
    };

    # borgmatic.settings = {
    #   source_directories = [ ];
    #   postgresql_databases = [
    #     {
    #       name = "ddns-updater";
    #       hostname = "localhost";
    #       username = "root";
    #       password = "{credential systemd borgmatic-pg}";
    #     }
    #   ];
    # };
  };
}
