{
  lib,
  ...
}:
let
  port = "5005";
in
{
  services = {
    qbittorrent = {
      enable = true;
      webuiPort = lib.toInt port;
      profileDir = "/srv";
      group = "media";
      extraArgs = [
        "--confirm-legal-notice"
      ];
    };

    nginx.virtualHosts."qbittorrent.fi33.buzz" = {
      forceSSL = true;
      useACMEHost = "fi33.buzz";
      locations."/".proxyPass = "http://localhost:${port}";
    };
  };

  users.users.qbittorrent.extraGroups = [ "media" ];
}
