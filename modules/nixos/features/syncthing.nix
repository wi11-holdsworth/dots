{
  config,
  lib,
  userName,
  hostName,
  ...
}:
let
  feature = "syncthing";
  port = "5008";

  devicesList = [
    {
      device = "desktop";
      id = "SKDADYB-DQVC2EG-BZ67OJR-DO25ZUR-URP2G5U-FXRNC65-OWPEKHN-STTRRQG";
    }
    {
      device = "laptop";
      id = "";
    }
    {
      device = "phone";
      id = "DF56S5M-2EDKAML-LZBB35J-MNNK7UE-WAYE2QW-EKUGKXN-U5JW3RX-S3FUGA4";
    }
    {
      device = "server";
      id = "OP7EU3A-7A4CCMY-D4T3ND7-YWMRBNJ-KVE34FG-ZJQFSLS-WMLRWB4-FL2O7AZ";
    }
  ];

  devices = builtins.listToAttrs (
    map (
      { device, id }:
      {
        name = device;
        value = {
          addresses = [
            "tcp://${device}:22000"
          ];
          autoAcceptFolders = true;
          inherit id;
        };
      }
    ) (builtins.filter (deviceSet: deviceSet.device != hostName) devicesList)
  );
in
{
  config = lib.mkIf config.${feature}.enable {
    services = {
      # service
      syncthing = {
        enable = true;
        guiAddress = "0.0.0.0:${port}";
        openDefaultPorts = true;
        user = "${userName}";
        dataDir = "/home/${userName}";
        overrideDevices = true;
        settings = {
          inherit devices;
        };
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
