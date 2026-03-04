let
  port = 5984;
  certloc = "/var/lib/acme/fi33.buzz";
  hostname = "couchdb.fi33.buzz";
  url = "https://${hostname}";
in
{
  services = {
    couchdb = {
      enable = true;
      databaseDir = "/srv/couchdb";
      viewIndexDir = "/srv/couchdb";
      configFile = "/srv/couchdb";
      inherit port;
      extraConfig = {
        chttpd = {
          require_valid_user = true;
          enable_cors = true;
          max_http_request_size = 4294967296;
        };

        chttpd_auth.require_valid_user = true;

        httpd = {
          WWW-Authenticate = ''Basic realm="couchdb"'';
          enable_cors = true;
        };

        couchdb.max_document_size = 50000000;

        cors = {
          credentials = true;
          origins = ''
            app://obsidian.md,capacitor://localhost,http://localhost,https://localhost,capacitor://${hostname},http://${hostname},${url}
          '';
        };
      };
    };

    gatus.settings.endpoints = [
      {
        name = "CouchDB";
        group = "Private Services";
        inherit url;
        interval = "5m";
        conditions = [
          "[STATUS] == 401"
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
}
