{
  # keep-sorted start
  lib,
  pkgs,
  # keep-sorted end
  ...
}:
let
  port = 5019;
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

  services.nginx.virtualHosts."qui.fi33.buzz" = {
    forceSSL = true;
    useACMEHost = "fi33.buzz";
    locations."/".proxyPass = "http://localhost:${toString port}";
  };
}
