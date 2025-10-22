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
    "lidarr"
    "miniflux"
    "nginx"
    "ntfy-sh"
    "owntracks"
    "paperless"
    "prowlarr"
    "qbittorrent"
    "radarr"
    "sonarr"
    "syncthing"
    "vaultwarden"
    # keep-sorted end
  ];

  users.groups.media = { };

  services.borgmatic.settings.source_directories = [ "/srv" ];
}
