let
  port = 5023;
  certloc = "/var/lib/acme/fi33.buzz";
in
{
  services = {
    libretranslate = {
      enable = true;
      inherit port;
      updateModels = true;
    };

    caddy.virtualHosts."translate.fi33.buzz".extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };
}
