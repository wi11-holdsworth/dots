{ config, lib, ... }:
let
  feature = "nginx";
  cfg = config.${feature};

in {
  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";

  config = lib.mkIf cfg.enable {
    age.secrets."api-porkbun" = { file = ../../../secrets/api-porkbun.age; };

    services.${feature} = {
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
        group = "${feature}";
        dnsProvider = "porkbun";
        dnsPropagationCheck = true;
        credentialsFile = config.age.secrets."api-porkbun".path;
      };
    };

    users.users.${feature}.extraGroups = [ "acme" ];
  };
}
