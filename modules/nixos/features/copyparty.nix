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
      };

      accounts.will.passwordFile = config.age.secrets.copyparty-will.path;

      volumes."/" = {
        path = "/srv/copyparty";
        access = {
          r = "*";
          A = [ "will" ];
        };
      };
    };

    caddy.virtualHosts."copyparty.fi33.buzz".extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };

  # secrets
  age.secrets."copyparty-will" = {
    file = ../../../secrets/copyparty-will.age;
    owner = "copyparty";
  };

  nixpkgs.overlays = [ inputs.copyparty.overlays.default ];
}
