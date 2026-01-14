let
  port = 5002;
  certloc = "/var/lib/acme/fi33.buzz";
in
{
  services = {
    ntfy-sh = {
      enable = true;
      settings = {
        base-url = "https://ntfy-sh.fi33.buzz";
        listen-http = ":${toString port}";
        behind-proxy = true;
      };
    };

    caddy.virtualHosts."ntfy-sh.fi33.buzz".extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };
}
