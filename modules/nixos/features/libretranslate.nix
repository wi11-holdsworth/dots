let
  port = 5023;
  certloc = "/var/lib/acme/fi33.buzz";
  hostname = "translate.fi33.buzz";
  url = "https://${hostname}";
in
{
  services = {
    libretranslate = {
      enable = true;
      inherit port;
      updateModels = true;
    };

    gatus.settings.endpoints = [
      {
        name = "LibreTranslate";
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

    caddy.virtualHosts.${hostname}.extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };
}
