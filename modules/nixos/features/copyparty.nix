{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
let
  feature = "copyparty";
  port = "5000";
in
{
  imports = [ inputs.copyparty.nixosModules.default ];

  config = lib.mkIf config.${feature}.enable {
    environment.systemPackages = [ pkgs.copyparty ];
    nixpkgs.overlays = [ inputs.copyparty.overlays.default ];

    age.secrets."copyparty-will" = {
      file = ../../../secrets/copyparty-will.age;
      owner = "copyparty";
    };

    services = {
      # service
      ${feature} = {
        enable = true;
        settings = {
          z = true;
          e2dsa = true;
          e2ts = true;
          e2vu = true;
          p = lib.toInt port;
        };

        accounts = {
          will = {
            passwordFile = config.age.secrets.copyparty-will.path;
          };
        };

        volumes = {
          "/" = {
            path = "/srv/copyparty";
            access = {
              r = "*";
              A = [ "will" ];
            };
          };
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
