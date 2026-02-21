{
  util,
  ...
}:
{
  imports = util.toImports ../features [
    # keep-sorted start
    "bazarr"
    "caddy"
    "copyparty"
    "couchdb"
    "homepage-dashboard"
    "immich"
    "jellyfin"
    "kavita"
    "lidarr"
    "miniflux"
    "ntfy-sh"
    "nzbget"
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
