{
  config,
  ...
}:
{
  services.caddy = {
    enable = true;
    dataDir = "/srv/caddy";
    globalConfig = ''
      auto_https disable_redirects

    '';
    extraConfig = "";
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "festive-steed-fit@duck.com";
    certs."fi33.buzz" = {
      group = config.services.caddy.group;
      domain = "fi33.buzz";
      extraDomainNames = [ "*.fi33.buzz" ];
      dnsProvider = "porkbun";
      dnsPropagationCheck = true;
      credentialsFile = config.age.secrets."porkbun-api".path;
    };
  };

  age.secrets."porkbun-api".file = ../../../secrets/porkbun-api.age;
}
