{
  config,
  ...
}:
let
  port = 5010;
  certloc = "/var/lib/acme/fi33.buzz";
in
{
  services = {
    miniflux = {
      enable = true;
      adminCredentialsFile = config.age.secrets.miniflux-creds.path;
      config = {
        BASE_URL = "https://miniflux.fi33.buzz";
        LISTEN_ADDR = "localhost:${toString port}";
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

    caddy.virtualHosts."miniflux.fi33.buzz".extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };

  age.secrets."miniflux-creds".file = ../../../secrets/miniflux-creds.age;
}
