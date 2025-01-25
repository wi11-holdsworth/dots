{
  config,
  ...

}: {

  age.secrets."api-porkbun" = {
    file = ../../secrets/api-porkbun.age; 
  };

  services.nginx = {
    enable = true;

    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;

  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "wi11@duck.com";
    certs."fi33.buzz" = {
      domain = "fi33.buzz";
      extraDomainNames = [ "*.fi33.buzz" ];
      group = "nginx";
      dnsProvider = "porkbun";
      dnsPropagationCheck = true;
      credentialsFile = config.age.secrets."api-porkbun".path;
    };
  };

  users.users.nginx.extraGroups = [ "acme" ];
}
