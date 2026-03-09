{
  pkgs,
  ...
}:
let
  port = 5009;
  certloc = "/var/lib/acme/fi33.buzz";
  hostname = "prowlarr.fi33.buzz";
  url = "https://${hostname}";
in
{
  services = {
    prowlarr = {
      enable = true;
      settings.server = {
        inherit port;
      };
    };

    gatus.settings.endpoints = [
      {
        name = "Prowlarr";
        group = "Media Management";
        inherit url;
        interval = "5m";
        conditions = [
          "[STATUS] == 200"
          "[CONNECTED] == true"
          "[RESPONSE_TIME] < 500"
        ];
        alerts = [ { type = "ntfy"; } ];
      }
    ];

    borgbackup.jobs = {
      onsite = {
        paths = [ "/var/lib/prowlarr" ];
      };
      offsite = {
        paths = [ "/var/lib/prowlarr" ];
      };
    };

    caddy.virtualHosts.${hostname}.extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };
}
