let
  port = 5009;
  certloc = "/var/lib/acme/fi33.buzz";
in
{
  services = {
    prowlarr = {
      enable = true;
      settings.server = {
        inherit port;
      };
    };

    borgmatic.settings.source_directories = [ "/var/lib/prowlarr" ];

    caddy.virtualHosts."prowlarr.fi33.buzz".extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };
}
