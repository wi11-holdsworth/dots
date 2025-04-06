{ config, lib, pkgs, ... }:
let
  feature = "aria2";
  port = "6800";
  cfg = config.${feature}; # TODO: dependent on agenix

in {
  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";

  config = lib.mkIf cfg.enable {
    services = {
      ${feature} = {
        enable = true;
        rpcSecretFile = config.age.secrets."aria2".path;
        downloadDirPermission = "0775";
        settings.dir = "/media";
      };

      # reverse proxy
      nginx.virtualHosts."${feature}.fi33.buzz" = {
        forceSSL = true;
        useACMEHost = "fi33.buzz";
        locations = {
          "/".root = "${pkgs.ariang}/share/ariang";
          "/jsonrpc".proxyPass = "http://localhost:${port}";
        };
      };
    };

    environment.systemPackages = [ pkgs.ariang ];

    # rpc password
    age.secrets."aria2".file = ../../../secrets/aria2.age;
  };
}
