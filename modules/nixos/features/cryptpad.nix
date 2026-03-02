let
  httpPort = 5022;
  websocketPort = 5024;
  certloc = "/var/lib/acme/fi33.buzz";
in
{
  services = {
    cryptpad = {
      enable = true;
      settings = {
        inherit httpPort;
        inherit websocketPort;
        httpUnsafeOrigin = "https://cryptpad.fi33.buzz";
        httpSafeOrigin = "https://cryptpad-ui.fi33.buzz";
        inactiveTime = 7;
        archiveRetentionTime = 7;
        accountRetentionTime = 7;
      };
    };

    caddy.virtualHosts."cryptpad.fi33.buzz, cryptpad-ui.fi33.buzz".extraConfig = ''
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
        host cryptpad.fi33.buzz
        path /register*
      }
      respond @register 403

      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };
}
