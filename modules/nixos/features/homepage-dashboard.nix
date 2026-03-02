{
  # keep-sorted start
  config,
  lib,
  pkgs,
  # keep-sorted end
  ...
}:
let
  port = 5004;
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
    "kavita-api"
    "lidarr"
    "miniflux"
    "nzbget"
    "paperless"
    "prowlarr"
    "radarr"
    "readarr"
    "sonarr"
    "subtitles"
    # keep-sorted end
  ];
  certloc = "/var/lib/acme/fi33.buzz";
in
{
  services = {
    homepage-dashboard = {
      enable = true;
      listenPort = port;
      allowedHosts = "homepage-dashboard.fi33.buzz";
      services = [
        {
          "Public Services" = [
            {
              CryptPad = {
                description = "Collaborative office suite";
                icon = "cryptpad.svg";
                href = "https://cryptpad.fi33.buzz/";
              };
            }
            {
              LibreTranslate = {
                description = "Machine Translation API";
                icon = "libretranslate.svg";
                href = "https://translate.fi33.buzz/";
              };
            }
            {
              Send = {
                description = "Simple, private file sharing";
                icon = "send.svg";
                href = "https://send.fi33.buzz/";
              };
            }
          ];
        }
        {
          "Media Management" = [
            {
              Radarr = {
                description = "Movie organizer/manager";
                icon = "radarr.svg";
                href = "https://radarr.fi33.buzz/";
                widget = {
                  type = "radarr";
                  url = "https://radarr.fi33.buzz/";
                  key = "@radarr@";
                  enableQueue = true;
                };
              };
            }
            {
              Sonarr = {
                description = "Smart PVR";
                icon = "sonarr.svg";
                href = "https://sonarr.fi33.buzz/";
                widget = {
                  type = "sonarr";
                  url = "https://sonarr.fi33.buzz/";
                  key = "@sonarr@";
                  enableQueue = true;
                };
              };
            }
            {
              Lidarr = {
                description = "Like Sonarr but made for music";
                icon = "lidarr.svg";
                href = "https://lidarr.fi33.buzz/";
                widget = {
                  type = "lidarr";
                  url = "https://lidarr.fi33.buzz/";
                  key = "@lidarr@";
                  enableQueue = true;
                };
              };
            }
            {
              Readarr = {
                description = "Book Manager and Automation";
                icon = "readarr.svg";
                href = "https://readarr.fi33.buzz/";
                widget = {
                  type = "readarr";
                  url = "https://readarr.fi33.buzz/";
                  key = "@readarr@";
                  enableQueue = true;
                };
              };
            }
            {
              Bazarr = {
                description = "Subtitle manager and downloader";
                icon = "bazarr.svg";
                href = "https://bazarr.fi33.buzz/";
                widget = {
                  type = "bazarr";
                  url = "https://bazarr.fi33.buzz/";
                  key = "@subtitles@";
                };
              };
            }
            {
              Prowlarr = {
                description = "Indexer manager/proxy";
                icon = "prowlarr.svg";
                href = "https://prowlarr.fi33.buzz/";
                widget = {
                  type = "prowlarr";
                  url = "https://prowlarr.fi33.buzz/";
                  key = "@prowlarr@";
                };
              };
            }
            {
              NZBget = {
                description = "Usenet Downloader";
                icon = "nzbget.svg";
                href = "https://nzbget.fi33.buzz/";
                widget = {
                  type = "nzbget";
                  url = "https://nzbget.fi33.buzz/";
                  username = "nzbget";
                  password = "@nzbget@";
                };
              };
            }
            {
              qBittorrent = {
                description = "BitTorrent client";
                icon = "qbittorrent.svg";
                href = "https://qbittorrent.fi33.buzz/";
              };
            }
          ];
        }
        {
          "Private Services" = [
            {
              copyparty = {
                description = "Portable file server";
                icon = "sh-copyparty.svg";
                href = "https://copyparty.fi33.buzz/";
              };
            }
            {
              CouchDB = {
                description = "Syncing database";
                icon = "couchdb.svg";
                href = "https://couchdb.fi33.buzz/_utils/";
              };
            }
            {
              ntfy = {
                description = "Send push notifications using PUT/POST";
                icon = "ntfy.svg";
                href = "https://ntfy-sh.fi33.buzz/";
              };
            }
            {
              Radicale = {
                description = "A simple CalDAV (calendar) and CardDAV (contact) server";
                icon = "radicale.svg";
                href = "https://radicale.fi33.buzz";
              };
            }
            {
              Syncthing = {
                description = "Open Source Continuous File Synchronization";
                icon = "syncthing.svg";
                href = "https://syncthing.fi33.buzz/";
              };
            }
            {
              Vaultwarden = {
                description = "Unofficial Bitwarden compatible server";
                icon = "vaultwarden.svg";
                href = "https://vaultwarden.fi33.buzz/";
              };
            }
          ];
        }
        {
          "Media Streaming" = [
            {
              Immich = {
                description = "Photo and video management solution";
                icon = "immich.svg";
                href = "https://immich.fi33.buzz/";
                widget = {
                  type = "immich";
                  fields = [
                    "users"
                    "photos"
                    "videos"
                    "storage"
                  ];
                  url = "https://immich.fi33.buzz/";
                  version = 2;
                  key = "@immich@";
                };
              };
            }
            {
              Jellyfin = {
                description = "Media System";
                icon = "jellyfin.svg";
                href = "https://jellyfin.fi33.buzz/";
                widget = {
                  type = "jellyfin";
                  url = "https://jellyfin.fi33.buzz/";
                  key = "@jellyfin@";
                  enableBlocks = true;
                  enableNowPlaying = true;
                  enableUser = true;
                  showEpisodeNumber = true;
                  expandOneStreamToTwoRows = false;
                };
              };
            }
            {
              Kavita = {
                description = "Reading server";
                icon = "kavita.svg";
                href = "https://kavita.fi33.buzz/";
                widget = {
                  type = "kavita";
                  url = "https://kavita.fi33.buzz/";
                  key = "@kavita-api@";
                };
              };
            }
            {
              Miniflux = {
                description = "Feed reader";
                icon = "miniflux.svg";
                href = "https://miniflux.fi33.buzz/";
                widget = {
                  type = "miniflux";
                  url = "https://miniflux.fi33.buzz/";
                  key = "@miniflux@";
                };
              };
            }
            {
              Paperless = {
                description = "Document management system";
                icon = "paperless.svg";
                href = "https://paperless.fi33.buzz/";
                widget = {
                  type = "paperlessngx";
                  url = "https://paperless.fi33.buzz/";
                  username = "admin";
                  password = "@paperless@";
                };
              };
            }
          ];
        }
        {
          Utilities = [
            {
              NanoKVM = {
                description = "Remote KVM switch";
                icon = "mdi-console.svg";
                href = "http://nano-kvm/";
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
            "Public Services" = {
              style = "row";
              columns = 3;
              useEqualHeights = true;
            };
          }
          {
            "Private Services" = {
              style = "row";
              columns = 3;
              useEqualHeights = true;
            };
          }
          {
            "Media Streaming" = {
              style = "row";
              columns = 3;
              useEqualHeights = true;
            };
          }
          {
            "Media Management" = {
              style = "row";
              columns = 3;
              useEqualHeights = true;
            };
          }
          {
            Utilities = {
              style = "row";
              columns = 3;
              useEqualHeights = true;
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
              "/mnt/external"
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

    caddy.virtualHosts."homepage-dashboard.fi33.buzz".extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };

  # secrets
  age.secrets = genSecrets secrets;
  system.activationScripts = insertSecrets secrets;
}
