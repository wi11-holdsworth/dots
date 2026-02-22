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
        auth-default-access = "deny-all";
        auth-users = [
          "Debit3885:$2a$12$ZeFimzdifNFSmf0W2oi.vuZfsqae75md9nhC/Q2BcKMyvDO8T.uEK:admin"
          "borgmatic:$2a$12$ZeFimzdifNFSmf0W2oi.vuZfsqae75md9nhC/Q2BcKMyvDO8T.uEK:user"
        ];
        auth-access = [ "borgmatic:backups:wo" ];
      };
    };

    borgmatic.settings = {
      source_directories = [
        "/var/lib/ntfy-sh/user.db"
      ];
    };

    caddy.virtualHosts."ntfy-sh.fi33.buzz".extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };
}
