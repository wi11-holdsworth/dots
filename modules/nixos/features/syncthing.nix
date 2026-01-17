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
      id = "XDDGWB2-5OFYWSY-7LN652V-3WNQMWV-4WCVHCR-2EXLDW7-FUL2MC4-MMLO4QV";
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

    borgmatic.settings =
      if userName == "srv" then
        {
          source_directories = [
            "/home/srv/.config/syncthing"
            "/home/srv/Sync"
          ];
        }
      else
        null;

    caddy.virtualHosts."syncthing.fi33.buzz".extraConfig = ''
      forward_auth unix//run/tailscale-nginx-auth/tailscale-nginx-auth.sock {
        uri /auth
        header_up Remote-Addr {remote_host}
        header_up Remote-Port {remote_port}
        header_up Original-URI {uri}
        copy_headers {
          Tailscale-User>X-Webauth-User
          Tailscale-Name>X-Webauth-Name
          Tailscale-Login>X-Webauth-Login
          Tailscale-Tailnet>X-Webauth-Tailnet
          Tailscale-Profile-Picture>X-Webauth-Profile-Picture
        }
      }
      reverse_proxy http://localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };
}
