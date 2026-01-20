{
  util,
  ...
}:
{
  imports = util.toImports ../features [
    # keep-sorted start
    "bazarr"
    "caddy"
    "calibre-server"
    "copyparty"
    "couchdb"
    "firefly"
    "homepage-dashboard"
    "immich"
    "jellyfin"
    "karakeep"
    "kavita"
    "lidarr"
    "miniflux"
    "ntfy-sh"
    "nzbget"
    "paperless"
    "prowlarr"
    "qbittorrent"
    "qui"
    "radarr"
    "radicale"
    "readarr"
    "sonarr"
    "syncthing"
    "upbank2firefly"
    "vaultwarden"
    # keep-sorted end
  ];

  services.borgmatic.settings.source_directories = [ "/srv" ];
}
