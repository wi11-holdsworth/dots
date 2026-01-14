{
  # keep-sorted start
  lib,
  pkgs,
  # keep-sorted end
  ...
}:
let
  port = 5019;
  certloc = "/var/lib/acme/fi33.buzz";
in
{
  environment.systemPackages = [ pkgs.qui ];

  systemd.user.services.qui = {
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig.ExecStart = "${lib.getExe pkgs.qui} serve";

    environment = {
      QUI__PORT = toString port;
      QUI__DATA_DIR = "/srv/qui";
    };
  };

  services.caddy.virtualHosts."qui.fi33.buzz".extraConfig = ''
    reverse_proxy localhost:${toString port}
    tls ${certloc}/cert.pem ${certloc}/key.pem {
      protocols tls1.3
    }
  '';
}
