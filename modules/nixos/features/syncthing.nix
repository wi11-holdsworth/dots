{
  config,
  lib,
  userName,
  ...
}:
let
  feature = "syncthing";
  port = "5008";
in
{
  config = lib.mkIf config.${feature}.enable {
    services = {
      # service
      syncthing = {
        enable = true;
        guiAddress = "127.0.0.1:${port}";
        openDefaultPorts = true;
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
