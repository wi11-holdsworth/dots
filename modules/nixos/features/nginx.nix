{ config, lib, ... }:
let
  # declare the module name and its local module dependencies
  feature = "nginx";
  dependencies = with config; [ age core ];

  # helper functions
  dependenciesEnabled = (lib.all (dep: dep.enable) dependencies);
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled && dependenciesEnabled;

in {
  config = lib.mkIf enabled {
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

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
