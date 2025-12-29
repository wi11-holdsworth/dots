{
  config,
  ...
}:
let
  port = 5003;
in
{
  services = {
    radicale = {
      enable = true;
      settings = {
        server = {
          hosts = [
            "0.0.0.0:${toString port}"
            "[::]:${toString port}"
          ];
        };
        auth = {
          type = "htpasswd";
          htpasswd_filename = config.age.secrets.radicale.path;
          htpasswd_encryption = "plain";
        };
        storage = {
          filesystem_folder = "/srv/radicale";
        };
      };
    };

    nginx.virtualHosts."radicale.fi33.buzz" = {
      forceSSL = true;
      useACMEHost = "fi33.buzz";
      locations."/".proxyPass = "http://localhost:${toString port}";
    };
  };

  # secrets
  age.secrets."radicale" = {
    file = ../../../secrets/radicale.age;
    owner = "radicale";
  };
}
