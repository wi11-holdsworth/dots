{
  # keep-sorted start
  config,
  lib,
  pkgs,
  # keep-sorted end
  ...
}:
let
  port = "5004";
  genSecrets =
    secrets:
    lib.genAttrs secrets (secret: {
      file = ../../../secrets/${secret}.age;
    });
  insertSecrets =
    secrets:
    lib.genAttrs secrets (secret: ''
      secret=$(cat "${config.age.secrets.${secret}.path}")
      configFile=/etc/homepage-dashboard/services.yaml
      ${pkgs.gnused}/bin/sed -i "s#@${secret}@#$secret#" "$configFile"
    '');

  secrets = [
    # keep-sorted start
    "immich"
    "jellyfin"
    "lidarr"
    "miniflux"
    "paperless"
    "prowlarr"
    "radarr"
    "sonarr"
    # keep-sorted end
  ];
in
{
  services = {
    homepage-dashboard = {
      enable = true;
      listenPort = lib.toInt port;
      allowedHosts = "homepage-dashboard.fi33.buzz";
      services = [
        # keep-sorted start block=yes
        {
          "Cloud Services" = [
            {
              "copyparty" = {
                "description" = "Cloud file manager";
                "icon" = "sh-copyparty.svg";
                "href" = "https://copyparty.fi33.buzz/";
              };
            }
            {
              "CouchDB" = {
                "description" = "Obsidian sync database";
                "icon" = "couchdb.svg";
                "href" = "https://couchdb.fi33.buzz/_utils/";
              };
            }
            {
              "ntfy" = {
                "description" = "Notification service";
                "icon" = "ntfy.svg";
                "href" = "https://ntfy-sh.fi33.buzz/";
              };
            }
            {
              "Syncthing" = {
                "description" = "Decentralised file synchronisation";
                "icon" = "syncthing.svg";
                "href" = "https://syncthing.fi33.buzz/";
              };
            }
            {
              "qBittorrent" = {
                "description" = "BitTorrent client";
                "icon" = "qbittorrent.svg";
                "href" = "https://qbittorrent.fi33.buzz/";
              };
            }
            {
              "Vaultwarden" = {
                "description" = "Password manager";
                "icon" = "vaultwarden.svg";
                "href" = "https://vaultwarden.fi33.buzz/";
              };
            }
          ];
        }
        {
          "Media Management" = [
            {
              "Lidarr" = {
                "description" = "Music collection manager";
                "icon" = "lidarr.svg";
                "href" = "https://lidarr.fi33.buzz/";
                "widget" = {
                  "type" = "lidarr";
                  "url" = "https://lidarr.fi33.buzz/";
                  "key" = "@lidarr@";
                  "enableQueue" = true;
                };
              };
            }
            {
              "Prowlarr" = {
                "description" = "Indexer management tool";
                "icon" = "prowlarr.svg";
                "href" = "https://prowlarr.fi33.buzz/";
                "widget" = {
                  "type" = "prowlarr";
                  "url" = "https://prowlarr.fi33.buzz/";
                  "key" = "@prowlarr@";
                };
              };
            }
            {
              "Radarr" = {
                "description" = "Movie collection manager";
                "icon" = "radarr.svg";
                "href" = "https://radarr.fi33.buzz/";
                "widget" = {
                  "type" = "radarr";
                  "url" = "https://radarr.fi33.buzz/";
                  "key" = "@radarr@";
                  "enableQueue" = true;
                };
              };
            }
            {
              "Sonarr" = {
                "description" = "TV show collection manager";
                "icon" = "sonarr.svg";
                "href" = "https://sonarr.fi33.buzz/";
                "widget" = {
                  "type" = "sonarr";
                  "url" = "https://sonarr.fi33.buzz/";
                  "key" = "@sonarr@";
                  "enableQueue" = true;
                };
              };
            }
          ];
        }
        {
          "Media Streaming" = [
            {
              "Immich" = {
                "description" = "Photo backup";
                "icon" = "immich.svg";
                "href" = "https://immich.fi33.buzz/";
                "widget" = {
                  "type" = "immich";
                  "fields" = [
                    "users"
                    "photos"
                    "videos"
                    "storage"
                  ];
                  "url" = "https://immich.fi33.buzz/";
                  "version" = 2;
                  "key" = "@immich@";
                };
              };
            }
            {
              "Jellyfin" = {
                "description" = "Media streaming";
                "icon" = "jellyfin.svg";
                "href" = "https://jellyfin.fi33.buzz/";
                "widget" = {
                  "type" = "jellyfin";
                  "url" = "https://jellyfin.fi33.buzz/";
                  "key" = "@jellyfin@";
                  "enableBlocks" = true;
                  "enableNowPlaying" = true;
                  "enableUser" = true;
                  "showEpisodeNumber" = true;
                  "expandOneStreamToTwoRows" = false;
                };
              };
            }
            {
              "Miniflux" = {
                "description" = "RSS aggregator";
                "icon" = "miniflux.svg";
                "href" = "https://miniflux.fi33.buzz/";
                "widget" = {
                  "type" = "miniflux";
                  "url" = "https://miniflux.fi33.buzz/";
                  "key" = "@miniflux@";
                };
              };
            }
            {
              "Paperless" = {
                "description" = "Digital filing cabinet";
                "icon" = "paperless.svg";
                "href" = "https://paperless.fi33.buzz/";
                "widget" = {
                  "type" = "paperlessngx";
                  "url" = "https://paperless.fi33.buzz/";
                  "username" = "admin";
                  "password" = "@paperless@";
                };
              };
            }
          ];
        }
        {
          "Utilities" = [
            {
              "NanoKVM" = {
                "description" = "Remote KVM switch";
                "icon" = "mdi-console.svg";
                "href" = "http://nano-kvm/";
              };
            }
          ];
        }
        # keep-sorted end
      ];
      settings = {
        title = "Mission Control";
        theme = "dark";
        color = "neutral";
        headerStyle = "clean";
        layout = [
          {
            "Media Streaming" = {
              style = "row";
              columns = 4;
              useEqualHeights = true;
            };
          }
          {
            "Media Management" = {
              style = "row";
              columns = 4;
              useEqualHeights = true;
            };
          }
          {
            "Cloud Services" = {
              style = "row";
              columns = 3;
            };
          }
          {
            "Utilities" = {
              style = "row";
              columns = 3;
            };
          }
        ];
        quicklaunch.searchDescriptions = true;
        disableUpdateCheck = true;
        showStats = true;
        statusStyle = "dot";
      };
      widgets = [
        {
          search = {
            provider = [
              "duckduckgo"
              "brave"
            ];
            focus = true;
            showSearchSuggestions = true;
            target = "_blank";
          };
        }
        {
          resources = {
            cpu = true;
            memory = true;
            disk = [
              "/"
              "/backup"
            ];
            cputemp = true;
            tempmin = 0;
            tempmax = 100;
            units = "metric";
            network = true;
            uptime = true;
          };
        }
      ];
    };

    nginx.virtualHosts."homepage-dashboard.fi33.buzz" = {
      forceSSL = true;
      useACMEHost = "fi33.buzz";
      locations."/".proxyPass = "http://localhost:${port}";
    };
  };

  # secrets
  age.secrets = genSecrets secrets;
  system.activationScripts = insertSecrets secrets;
}
