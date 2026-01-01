{
  # keep-sorted start
  config,
  inputs,
  # keep-sorted end
  ...
}:
let
  port = 5000;
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

    nginx.virtualHosts."copyparty.fi33.buzz" = {
      forceSSL = true;
      useACMEHost = "fi33.buzz";
      locations."/".proxyPass = "http://localhost:${toString port}";
    };
  };

  # secrets
  age.secrets."copyparty-will" = {
    file = ../../../secrets/copyparty-will.age;
    owner = "copyparty";
  };

  nixpkgs.overlays = [ inputs.copyparty.overlays.default ];
}
