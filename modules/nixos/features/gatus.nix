let
  port = 5025;
  certloc = "/var/lib/acme/fi33.buzz";
  hostname = "status.fi33.buzz";
  url = "https://${hostname}";
in
{
  services = {
    gatus = {
      enable = true;
      settings.web.port = port;
    };

    caddy.virtualHosts.${hostname}.extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };
}
