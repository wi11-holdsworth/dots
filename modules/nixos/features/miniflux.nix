{
  config,
  ...
}:
let
  port = "5010";
in
{
  services = {
    miniflux = {
      enable = true;
      adminCredentialsFile = config.age.secrets.miniflux-creds.path;
      config = {
        BASE_URL = "https://miniflux.fi33.buzz";
        LISTEN_ADDR = "localhost:${port}";
      };
    };

    borgmatic.settings.postgresql_databases = [
      {
        name = "miniflux";
        hostname = "localhost";
        username = "root";
        password = "{credential systemd borgmatic-pg}";
      }
    ];

    nginx.virtualHosts."miniflux.fi33.buzz" = {
      forceSSL = true;
      useACMEHost = "fi33.buzz";
      locations."/".proxyPass = "http://localhost:${port}";
    };
  };

  age.secrets."miniflux-creds".file = ../../../secrets/miniflux-creds.age;
}
