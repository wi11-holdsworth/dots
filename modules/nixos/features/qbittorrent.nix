{ config, lib, ... }:
let
  feature = "qbittorrent";
  port = "5005";
in
{
  config = lib.mkIf config.${feature}.enable {
    users.users.qbittorrent.extraGroups = [ "media" ];

    services = {
      # service
      qbittorrent = {
        enable = true;
        webuiPort = lib.toInt port;
        profileDir = "/srv";
        group = "media";
        extraArgs = [
          "--confirm-legal-notice"
        ];
      };

      # reverse proxy
      nginx = {
        virtualHosts."${feature}.fi33.buzz" = {
          forceSSL = true;
          useACMEHost = "fi33.buzz";
          locations."/" = {
            proxyPass = "http://localhost:${port}";
            # proxyWebsockets = true;
          };
        };
      };
    };
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
