{
  config,
  ...
}:
let
  port = 5015;
in
{
  services = {
    kavita = {
      enable = true;
      dataDir = "/srv/kavita";
      settings.Port = port;
      tokenKeyFile = config.age.secrets.kavita.path;
    };

    nginx.virtualHosts."kavita.fi33.buzz" = {
      forceSSL = true;
      useACMEHost = "fi33.buzz";
      locations."/".proxyPass = "http://localhost:${toString port}";
    };
  };

  age.secrets.kavita.file = ../../../secrets/kavita.age;
}
