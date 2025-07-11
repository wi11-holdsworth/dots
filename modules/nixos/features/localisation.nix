{ config, lib, ... }:
let
  feature = "localisation";
in
{
  config = lib.mkIf config.${feature}.enable {
    i18n = {
      defaultLocale = "en_AU.UTF-8";
      supportedLocales = [
        "en_US.UTF-8/UTF-8"
        "en_AU.UTF-8/UTF-8"
      ];
    };

    time.timeZone = "Australia/Melbourne";
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
