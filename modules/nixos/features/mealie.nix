{
  config,
  ...
}:
let
  port = 5026;
  certloc = "/var/lib/acme/fi33.buzz";
  hostname = "mealie.fi33.buzz";
  url = "https://${hostname}";
in
{
  services = {
    mealie = {
      enable = true;
      inherit port;
      settings = {
        TZ = "Australia/Melbourne";
        ALLOW_SIGNUP = "false";
      };
    };

    gatus.settings.endpoints = [
      {
        name = "Private Services";
        group = "";
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

    # borgmatic.settings = {
    #   source_directories = [ ];
    #   postgresql_databases = [
    #     {
    #       name = "mealie";
    #       hostname = "localhost";
    #       username = "root";
    #       password = "{credential systemd borgmatic-pg}";
    #     }
    #   ];
    # };

    caddy.virtualHosts.${hostname}.extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };
}
