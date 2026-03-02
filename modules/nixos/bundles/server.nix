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
    "cryptpad"
    "homepage-dashboard"
    "immich"
    "jellyfin"
    "kavita"
    "libretranslate"
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
    "send"
    "sonarr"
    "vaultwarden"
    # keep-sorted end
  ];

  services.borgmatic.settings.source_directories = [ "/srv" ];
}
