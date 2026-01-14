{
  config,
  ...
}:
let
  certloc = "/var/lib/acme/fi33.buzz";
in
{
  services = {
    firefly-iii = {
      enable = true;
      dataDir = "/srv/firefly";
      group = config.services.caddy.group;
      settings = {
        # keep-sorted start
        ALLOW_WEBHOOKS = "true";
        APP_KEY_FILE = config.age.secrets.firefly.path;
        APP_URL = "https://firefly.fi33.buzz";
        DEFAULT_LANGUAGE = "en_GB";
        REPORT_ERRORS_ONLINE = "false";
        TRUSTED_PROXIES = "**";
        TZ = "Australia/Melbourne";
        # keep-sorted end
      };
    };

    borgmatic.settings.sqlite_databases = [
      {
        name = "firefly";
        path = "/srv/firefly/storage/database/database.sqlite";
      }
    ];

    caddy.virtualHosts."firefly.fi33.buzz".extraConfig = ''
      root * ${config.services.firefly-iii.package}/public
      php_fastcgi unix//${config.services.phpfpm.pools.firefly-iii.socket}
      try_files {path} {path}/ /index.php?{query}
      file_server {
        index index.php
      }
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };

  age.secrets = {
    firefly = {
      file = ../../../secrets/firefly.age;
      owner = "firefly-iii";
    };
    firefly-db = {
      file = ../../../secrets/firefly-db.age;
      owner = "firefly-iii";
    };
  };
}
