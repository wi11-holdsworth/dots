{
  config,
  ...
}:
let
  port = 5015;
  certloc = "/var/lib/acme/fi33.buzz";
  hostname = "library.fi33.buzz";
  url = "https://${hostname}";
in
{
  services = {
    kavita = {
      enable = true;
      dataDir = "/srv/kavita";
      settings.Port = port;
      tokenKeyFile = config.age.secrets.kavita.path;
    };

    gatus.settings.endpoints = [
      {
        name = "Kavita";
        group = "Media Streaming";
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

  age.secrets.kavita.file = ../../../secrets/kavita.age;
}
