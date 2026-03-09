{
  config,
  ...
}:
let
  port = 5002;
  certloc = "/var/lib/acme/fi33.buzz";
  hostname = "notify.fi33.buzz";
  url = "https://${hostname}";
in
{
  services = {
    ntfy-sh = {
      enable = true;
      environmentFile = config.age.secrets.ntfy.path;
      settings = {
        base-url = url;
        listen-http = ":${toString port}";
        behind-proxy = true;
        auth-default-access = "deny-all";
        auth-users = [
          "Debit3885:$2a$12$ZeFimzdifNFSmf0W2oi.vuZfsqae75md9nhC/Q2BcKMyvDO8T.uEK:admin"
          "gatus:$2a$12$OswG3sB8oDaB.KpawKM3P.78dID.Tj/0y5qeVD5BE6EH5bpGKe.na:user"
        ];
        auth-access = [
          "gatus:services:wo"
        ];
      };
    };

    gatus.settings.endpoints = [
      {
        name = "ntfy";
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

    borgbackup.jobs = {
      onsite.paths = [ "/var/lib/ntfy-sh" ];
      offsite.paths = [ "/var/lib/ntfy-sh" ];
    };

    caddy.virtualHosts.${hostname}.extraConfig = ''
      reverse_proxy localhost:${toString port}
      tls ${certloc}/cert.pem ${certloc}/key.pem {
        protocols tls1.3
      }
    '';
  };

  age.secrets.ntfy.file = ../../../secrets/ntfy.age;
}
