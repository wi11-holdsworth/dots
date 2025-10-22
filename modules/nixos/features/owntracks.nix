{
  pkgs,
  ...
}:
let
  host = "owntracks.fi33.buzz";
  port = "5014";
in
{
  systemd.services.owntracks = {
    enable = true;
    description = "owntracks recorder";
    serviceConfig = {
      ExecStart = ''
        ${pkgs.owntracks-recorder}/bin/ot-recorder \
           --storage /var/lib/owntracks/recorder/store \
           --port 0
           --http-port ${port}
           --http-host https://${host}
      '';
      DynamicUser = true;
      StateDirectory = "owntracks";
      Restart = "always";
    };
    wantedBy = [ "multi-user.target" ];
  };
  services = {
    # borgbackup.jobs = owntracks { };

    nginx.virtualHosts.${host} =
      let
        owntracks-frontend = pkgs.callPackage ./owntracks-frontend.nix;
      in
      {
        forceSSL = true;
        useACMEHost = "fi33.buzz";
        root = "/var/www/html";
        locations."/owntracks/".alias = "${owntracks-frontend}";
      };
  };
}
