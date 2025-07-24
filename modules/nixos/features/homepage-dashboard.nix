{
  config,
  lib,
  pkgs,
  ...
}:
let
  feature = "homepage-dashboard";
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
    "immich"
    "jellyfin"
    "lidarr"
    "miniflux"
    "paperless"
    "prowlarr"
    "radarr"
    "sonarr"
  ];
in
{
  config = lib.mkIf config.${feature}.enable {
    system.activationScripts = insertSecrets secrets;
    age.secrets = genSecrets secrets;

    services = {
      # service
      ${feature} = {
        enable = true;
        listenPort = lib.toInt port;
        allowedHosts = "${feature}.fi33.buzz";
        services = [
          {
            "Media Management" = [
              {
                "Lidarr" = {
                  "description" = "Music collection manager";
                  "icon" = "lidarr.png";
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
                  "icon" = "prowlarr.png";
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
                  "icon" = "radarr.png";
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
                  "icon" = "sonarr.png";
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
                  "icon" = "immich.png";
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
                  "icon" = "jellyfin.png";
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
                  "icon" = "miniflux.png";
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
                  "icon" = "paperless.png";
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
            "Cloud Services" = [
              {
                "CouchDB" = {
                  "description" = "Obsidian sync database";
                  "icon" = "couchdb.png";
                  "href" = "https://couchdb.fi33.buzz/_utils/";
                };
              }
              {
                "Ntfy" = {
                  "description" = "Notification service";
                  "icon" = "ntfy.png";
                  "href" = "https://ntfy-sh.fi33.buzz/";
                };
              }
              {
                "qBittorrent" = {
                  "description" = "BitTorrent client";
                  "icon" = "qbittorrent.png";
                  "href" = "https://qbittorrent.fi33.buzz/";
                };
              }
              {
                "Stirling PDF" = {
                  "description" = "PDF toolbox";
                  "icon" = "stirling-pdf.png";
                  "href" = "https://stirling-pdf.fi33.buzz/";
                };
              }
              {
                "Vaultwarden" = {
                  "description" = "Password manager";
                  "icon" = "vaultwarden.png";
                  "href" = "https://vaultwarden.fi33.buzz/";
                };
              }
            ];
          }
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
              disk = "/";
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

      # reverse proxy
      nginx = {
        virtualHosts."${feature}.fi33.buzz" = {
          forceSSL = true;
          useACMEHost = "fi33.buzz";
          locations."/" = {
            proxyPass = "http://localhost:${port}";
            # proxyWebsockets = true;
          };
        };
      };
    };
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
