{
  util,
  ...
}:
{
  imports = util.toImports ../features [
    # keep-sorted start
    "bazarr"
    "copyparty"
    "couchdb"
    "homepage-dashboard"
    "immich"
    "jellyfin"
    "karakeep"
    "kavita"
    "lidarr"
    "miniflux"
    "nginx"
    "ntfy-sh"
    "paperless"
    "prowlarr"
    "qbittorrent"
    "radarr"
    "radicale"
    "readarr"
    "sonarr"
    "syncthing"
    "vaultwarden"
    # keep-sorted end
  ];

  services.borgmatic.settings.source_directories = [ "/srv" ];
}
