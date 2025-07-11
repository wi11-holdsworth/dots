{
  config,
  lib,
  ...
}:
let
  feature = "nginx";
in
{
  config = lib.mkIf config.${feature}.enable {
    age.secrets."api-porkbun" = {
      file = ../../../secrets/api-porkbun.age;
    };

    services.${feature} = {
      enable = true;

      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;

      virtualHosts."*.fi33.buzz" = {
        forceSSL = true;
        useACMEHost = "fi33.buzz";
        locations."/".index = "index.html";
      };
    };

    security.acme = {
      acceptTerms = true;
      defaults.email = "wi11@duck.com";
      certs."fi33.buzz" = {
        domain = "fi33.buzz";
        extraDomainNames = [ "*.fi33.buzz" ];
        group = "${feature}";
        dnsProvider = "porkbun";
        dnsPropagationCheck = true;
        credentialsFile = config.age.secrets."api-porkbun".path;
      };
    };

    users.users.${feature}.extraGroups = [ "acme" ];
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
