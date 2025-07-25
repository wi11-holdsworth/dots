{ config, lib, ... }:
let
  feature = "server";
in
{
  config = lib.mkIf config.${feature}.enable {
#    couchdb.enable = true;
    flaresolverr.enable = true;
    homepage-dashboard.enable = true;
    immich.enable = true;
    jellyfin.enable = true;
    lidarr.enable = true;
    miniflux.enable = true;
    nginx.enable = true;
    ntfy-sh.enable = true;
    paperless.enable = true;
    prowlarr.enable = true;
    radarr.enable = true;
    sonarr.enable = true;
    stirling-pdf.enable = true;
    qbittorrent.enable = true;
    vaultwarden.enable = true;
    vscode-server.enable = true;
    webdav.enable = true;

    users.groups.media = {};
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
