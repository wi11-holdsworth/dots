{
  util,
  ...
}:
{
  imports = util.toImports ../features [
    # keep-sorted start
    "copyparty"
    "couchdb"
    "flaresolverr"
    "homepage-dashboard"
    "immich"
    "jellyfin"
    "karakeep"
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

  users.groups.media = { };

  services.borgmatic.settings.source_directories = [ "/srv" ];
}
