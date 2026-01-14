let
  port = 5014;
  certloc = "/var/lib/acme/fi33.buzz";
in
{
  services = {
    karakeep = {
      enable = true;
      extraEnvironment = {
        PORT = toString port;
        DISABLE_NEW_RELEASE_CHECK = "true";
      };
    };

    caddy.virtualHosts."karakeep.fi33.buzz".extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };
}
