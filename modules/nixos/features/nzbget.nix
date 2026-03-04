{
  pkgs,
  ...
}:
let
  port = 5018;
  certloc = "/var/lib/acme/fi33.buzz";
  hostname = "usenet.fi33.buzz";
  url = "https://${hostname}";
in
{
  services = {
    nzbget = {
      enable = true;
      settings = {
        MainDir = "/srv/nzbget";
        ControlPort = port;
      };
      group = "srv";
    };

    gatus.settings.endpoints = [
      {
        name = "NZBget";
        group = "Media Management";
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

  environment.systemPackages = with pkgs; [ unrar ];
}
