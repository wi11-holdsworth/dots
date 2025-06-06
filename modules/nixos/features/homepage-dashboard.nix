{
  config,
  lib,
  pkgs,
  ...
}:
let
  # declare the module name and its local module dependencies
  feature = "homepage-dashboard";
  dependencies = with config; [
    core
    nginx
  ];
  port = "5004";

  # helper functions
  dependenciesEnabled = (lib.all (dep: dep.enable) dependencies);
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled && dependenciesEnabled;
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
    "prowlarr"
    "radarr"
    "sonarr"
  ];
in
{
  config = lib.mkIf enabled {
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
            Streaming = [
              {
                "Jellyfin" = {
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
                "Prowlarr" = {
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
            Media = [
              {
                "Immich" = {
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
            ];
          }
          {
            Services = [
              {
                "CouchDB" = {
                  "icon" = "couchdb.png";
                  "href" = "https://couchdb.fi33.buzz/_utils/";
                };
              }
              {
                "Dufs" = {
                  "icon" = "proton-drive.png";
                  "href" = "https://dufs.fi33.buzz/";
                };
              }
              {
                "Ntfy" = {
                  "icon" = "ntfy.png";
                  "href" = "https://ntfy-sh.fi33.buzz/";
                };
              }
              {
                "Stirling PDF" = {
                  "icon" = "stirling-pdf.png";
                  "href" = "https://stirling-pdf.fi33.buzz/";
                };
              }
              {
                "Transmission" = {
                  "icon" = "transmission.png";
                  "href" = "https://transmission.fi33.buzz/";
                };
              }
              {
                "Vaultwarden" = {
                  "icon" = "vaultwarden.png";
                  "href" = "https://vaultwarden.fi33.buzz/";
                };
              }
            ];
          }
        ];
        settings = {
          theme = "dark";
          color = "neutral";
          headerStyle = "clean";
          layout = {
            Streaming = {
              columns = 2;
              style = "row";
            };
            Media = { };
            Services = {
              style = "row";
              columns = 3;
            };
          };
        };
        widgets = [
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
