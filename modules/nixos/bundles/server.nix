{ config, lib, ... }:
let
  feature = "server";
in
{
  config = lib.mkIf config.${feature}.enable {
    # keep-sorted start
    copyparty.enable = true;
    couchdb.enable = true;
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
    qbittorrent.enable = true;
    radarr.enable = true;
    sonarr.enable = true;
    syncthing.enable = true;
    vaultwarden.enable = true;
    vscode-server.enable = true;
    # keep-sorted end

    users.groups.media = { };
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
