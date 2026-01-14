{
  config,
  ...
}:
let
  port = 5015;
  certloc = "/var/lib/acme/fi33.buzz";
in
{
  services = {
    kavita = {
      enable = true;
      dataDir = "/srv/kavita";
      settings.Port = port;
      tokenKeyFile = config.age.secrets.kavita.path;
    };

    caddy.virtualHosts."kavita.fi33.buzz".extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };

  age.secrets.kavita.file = ../../../secrets/kavita.age;
}
