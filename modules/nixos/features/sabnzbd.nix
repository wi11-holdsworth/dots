let
  port = "5015";
in
{
  services = {
    sabnzbd = {
      enable = true;
      configFile = "/srv/sabnzbd/sabnzbd.ini";
    };

    nginx.virtualHosts."sabnzbd.fi33.buzz" = {
      forceSSL = true;
      useACMEHost = "fi33.buzz";
      locations."/".proxyPass = "http://localhost:${port}";
    };
  };

  users.users.sabnzbd.extraGroups = [ "media" ];
}
