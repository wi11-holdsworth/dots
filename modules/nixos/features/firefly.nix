{
  config,
  ...
}:
{
  services = {
    firefly-iii = {
      enable = true;
      dataDir = "/srv/firefly";
      group = "nginx";
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

    nginx.virtualHosts."firefly.fi33.buzz" = {
      forceSSL = true;
      useACMEHost = "fi33.buzz";
      root = "${config.services.firefly-iii.package}/public";
      locations = {
        "/" = {
          tryFiles = "$uri $uri/ /index.php?$query_string";
          index = "index.php";
          extraConfig = ''
            sendfile off;
          '';
        };
        "~ \\.php$" = {
          extraConfig = ''
            include ${config.services.nginx.package}/conf/fastcgi_params ;
            fastcgi_param SCRIPT_FILENAME $request_filename;
            fastcgi_param modHeadersAvailable true; #Avoid sending the security headers twice
            fastcgi_pass unix:${config.services.phpfpm.pools.firefly-iii.socket};
          '';
        };
      };
    };
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
