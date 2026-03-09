{
  userName,
  hostName,
  ...
}:
let
  port = 5008;
  devicesList = [
    # keep-sorted start block=yes
    {
      device = "desktop";
      id = "SKDADYB-DQVC2EG-BZ67OJR-DO25ZUR-URP2G5U-FXRNC65-OWPEKHN-STTRRQG";
    }
    {
      device = "laptop";
      id = "CTU345T-27VU5KK-HXLPSMO-H6C47TL-XZG3BVU-AZF7HSX-FCQHAMA-QOA3CAT";
    }
    {
      device = "phone";
      id = "KAZ3SOB-SSJHY33-6JF64KW-VF3CPSP-565565I-YXOJHU6-E273VR5-CKQFNQ6";
    }
    {
      device = "server";
      id = "OP7EU3A-7A4CCMY-D4T3ND7-YWMRBNJ-KVE34FG-ZJQFSLS-WMLRWB4-FL2O7AZ";
    }
    # keep-sorted end
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
  certloc = "/var/lib/acme/fi33.buzz";
  hostname = "sync.fi33.buzz";
  url = "https://${hostname}";
in
{
  services = {
    syncthing = {
      enable = true;
      guiAddress = "0.0.0.0:${toString port}";
      openDefaultPorts = true;
      user = "${userName}";
      dataDir = "/home/${userName}";
      overrideDevices = true;
      settings = {
        inherit devices;
      };
    };

    gatus.settings.endpoints = [
      {
        name = "Syncthing";
        group = "Private Services";
        inherit url;
        interval = "5m";
        conditions = [
          "[STATUS] == 200"
          "[CONNECTED] == true"
          "[RESPONSE_TIME] < 500"
        ];
        alerts = [ { type = "ntfy"; } ];
      }
    ];

    borgbackup.jobs =
      if userName == "srv" then
        {
          onsite.paths = [
            "/home/srv/.config/syncthing"
            "/home/srv/Sync/"
          ];
          offsite.paths = [
            "/home/srv/.config/syncthing"
            "/home/srv/Sync/"
          ];
        }
      else
        null;

    caddy.virtualHosts.${hostname}.extraConfig = ''
      reverse_proxy http://localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };
}
