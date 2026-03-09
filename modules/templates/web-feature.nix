let
  port = 0000;
  certloc = "/var/lib/acme/fi33.buzz";
  hostname = "feature.fi33.buzz";
  url = "https://${hostname}";
in
{
  services = {
    feature = {
      enable = true;
    };

    gatus.settings.endpoints = [
      {
        name = "feature";
        group = "";
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
      onsite.paths = [ "" ];
      offsite.paths = [ "" ];
    };

    caddy.virtualHosts.${hostname}.extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };
}
