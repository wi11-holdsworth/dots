{ config, lib, pkgs, ... }:
let
  # declare the module name and its local module dependencies
  feature = "aria2";
  dependencies = with config; [ agenix nginx core ];
  port = "6800";

  # helper functions
  dependenciesEnabled = (lib.all (dep: dep.enable) dependencies);
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled && dependenciesEnabled;

in {
  config = lib.mkIf enabled {
    services = {
      ${feature} = {
        enable = true;
        rpcSecretFile = config.age.secrets."aria2".path;
        openPorts = true;
        downloadDirPermission = "0775";
        settings = {
          dir = "/media";
          rpc-listen-port = lib.toInt "${port}";
        };
      };

      # reverse proxy
      nginx.virtualHosts."${feature}.fi33.buzz" = {
        forceSSL = true;
        useACMEHost = "fi33.buzz";
        locations = {
          "/".root = "${pkgs.ariang}/share/ariang";
          "/jsonrpc" = {
            proxyPass = "http://localhost:${port}";
            proxyWebsockets = true;
          };
        };
      };
    };

    environment.systemPackages = [ pkgs.ariang ];

    # rpc password
    age.secrets."aria2".file = ../../../secrets/aria2.age;
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
