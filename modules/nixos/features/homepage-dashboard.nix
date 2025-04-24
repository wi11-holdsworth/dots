{ config, lib, ... }:
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

in
{
  config = lib.mkIf enabled {
    services = {
      # service
      ${feature} = {
        enable = true;
        listenPort = lib.toInt port;
        allowedHosts = "${feature}.fi33.buzz";
        services = [
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
                    "key" = "PjWkxJdRpsMikkT3lom6C9PjSo7ELMvgzlapJG2ufo";
                  };
                };
              }
              {
                "Jellyfin" = {
                  "icon" = "jellyfin.png";
                  "href" = "https://jellyfin.fi33.buzz/";
                  "widget" = {
                    "type" = "jellyfin";
                    "url" = "https://jellyfin.fi33.buzz/";
                    "key" = "9c642feb8ee8443b83e207bd987d1684";
                    "enableBlocks" = true;
                    "enableNowPlaying" = true;
                    "enableUser" = true;
                    "showEpisodeNumber" = true;
                    "expandOneStreamToTwoRows" = false;
                  };
                };
              }
            ];
          }
          {
            Services = [
              {
                "AriaNg" = {
                  "icon" = "ariang.png";
                  "href" = "https://aria2.fi33.buzz/";
                };
              }
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
          layout.Services = {
            style = "row";
            columns = 3;
          };
          layout.Media = { };
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
