{
  config,
  ...
}:
let
  port = 5003;
  certloc = "/var/lib/acme/fi33.buzz";
  hostname = "caldav.fi33.buzz";
  url = "https://${hostname}";
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

    gatus.settings.endpoints = [
      {
        name = "Radicale";
        group = "Private Services";
        inherit url;
        interval = "5m";
        conditions = [
          "[STATUS] == 200"
          "[CONNECTED] == true"
          "[RESPONSE_TIME] < 500"
        ];
      }
    ];

    caddy.virtualHosts.${hostname}.extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };

  # secrets
  age.secrets."radicale" = {
    file = ../../../secrets/radicale.age;
    owner = "radicale";
  };
}
