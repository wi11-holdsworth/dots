let
  certloc = "/var/lib/acme/fi33.buzz";
  hostname = "www.fi33.buzz";
in
{
  # TODO why can't I serve content on fi33.buzz? dns propagation issue?
  services.caddy.virtualHosts = {
    "fi33.buzz".extraConfig = ''
      redir https://www.fi33.buzz{uri} permanent
    '';
    ${hostname}.extraConfig = ''
      root * /srv/fi33.buzz/public
      file_server
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };
}
