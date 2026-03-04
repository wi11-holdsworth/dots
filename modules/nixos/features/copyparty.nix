{
  # keep-sorted start
  config,
  inputs,
  # keep-sorted end
  ...
}:
let
  port = 5000;
  certloc = "/var/lib/acme/fi33.buzz";
  hostname = "files.fi33.buzz";
  url = "https://${hostname}";
in
{
  imports = [ inputs.copyparty.nixosModules.default ];

  services = {
    copyparty = {
      enable = true;
      settings = {
        z = true;
        e2dsa = true;
        e2ts = true;
        e2vu = true;
        p = port;
        xff-hdr = "x-forwarded-for";
        rproxy = 1;
      };

      accounts.Impatient7119.passwordFile = config.age.secrets.copyparty.path;

      volumes."/" = {
        path = "/srv/copyparty";
        access = {
          A = [ "Impatient7119" ];
        };
      };
    };

    gatus.settings.endpoints = [
      {
        name = "copyparty";
        group = "Private Services";
        inherit url;
        interval = "5m";
        conditions = [
          "[STATUS] == 200"
          "[CONNECTED] == true"
          "[RESPONSE_TIME] < 500"
        ];
      }
    ];

    caddy.virtualHosts.${hostname}.extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };

  # secrets
  age.secrets."copyparty" = {
    file = ../../../secrets/copyparty.age;
    owner = "copyparty";
  };

  nixpkgs.overlays = [ inputs.copyparty.overlays.default ];
}
