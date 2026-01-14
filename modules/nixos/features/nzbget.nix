{
  pkgs,
  ...
}:
let
  port = 5018;
  certloc = "/var/lib/acme/fi33.buzz";
in
{
  services = {
    nzbget = {
      enable = true;
      settings = {
        MainDir = "/srv/nzbget";
        ControlPort = port;
      };
      group = "srv";
    };

    caddy.virtualHosts."nzbget.fi33.buzz".extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };

  environment.systemPackages = with pkgs; [ unrar ];
}
