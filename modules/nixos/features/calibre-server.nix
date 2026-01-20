let
  port = 5011;
  certloc = "/var/lib/acme/fi33.buzz";
in
{
  services = {
    calibre-server = {
      enable = true;
      extraFlags = [ "--trusted-ips=127.0.0.1" ];
      group = "srv";
      host = "127.0.0.1";
      inherit port;
      libraries = [ "/media/media/books" ];
    };

    caddy.virtualHosts."calibre.fi33.buzz".extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };
}
