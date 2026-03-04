let
  httpPort = 5022;
  websocketPort = 5024;
  certloc = "/var/lib/acme/fi33.buzz";
  hostname = "cryptpad.fi33.buzz";
  url = "https://${hostname}";
in
{
  services = {
    cryptpad = {
      enable = true;
      settings = {
        inherit httpPort;
        inherit websocketPort;
        httpUnsafeOrigin = url;
        httpSafeOrigin = "https://cryptpad-ui.fi33.buzz";
        inactiveTime = 7;
        archiveRetentionTime = 7;
        accountRetentionTime = 7;
      };
    };

    gatus.settings.endpoints = [
      {
        name = "CryptPad";
        group = "Public Services";
        inherit url;
        interval = "5m";
        conditions = [
          "[STATUS] == 200"
          "[CONNECTED] == true"
          "[RESPONSE_TIME] < 500"
        ];
      }
    ];

    caddy.virtualHosts."${hostname} cryptpad-ui.fi33.buzz".extraConfig = ''
      header Strict-Transport-Security "includeSubDomains; preload"

      handle /cryptpad_websocket* {
        reverse_proxy localhost:${toString websocketPort} {
          header_up Host {host}
          header_up X-Real-IP {remote_host}
        }
      }

      handle {
        reverse_proxy localhost:${toString httpPort} {
          header_up Host {host}
          header_up X-Real-IP {remote_host}
        }
      }

      @register {
        host ${hostname} 
        path /register*
      }
      respond @register 403

      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };
}
