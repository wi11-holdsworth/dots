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
    "fi33.buzz"
    "gatus"
    "homepage-dashboard"
    "immich"
    "jellyfin"
    "kavita"
    "libretranslate"
    "lidarr"
    "mealie"
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

  services.borgbackup.jobs = {
    onsite.paths = [ "/srv" ];
    offsite.paths = [ "/srv" ];
  };
}
