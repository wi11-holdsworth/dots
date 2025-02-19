{
  config,
  pkgs,
  ...

}: let 
  service = "aria2";
  port = "6800";

in {
  services = {
    "${service}" = {
      enable = true;
      rpcSecretFile = config.age.secrets."aria2".path;
      downloadDirPermission = "0775";
      settings.dir = "/media";
    };

    # reverse proxy
    nginx = {
      virtualHosts."${service}.fi33.buzz" = {
        forceSSL = true;
        useACMEHost = "fi33.buzz";
        locations = {
          "/".root = "${pkgs.ariang}/share/ariang";
          "/jsonrpc".proxyPass = "http://localhost:${port}";
        };
      };
    };
  };

  environment.systemPackages = [ pkgs.ariang ];

  # rpc password
  age.secrets."aria2".file = ../../../secrets/aria2.age;
}
