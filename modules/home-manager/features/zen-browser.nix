{
  config,
  lib,
  ...
}:
let
  feature = "zen-browser";
in
{
  config = lib.mkIf config.${feature}.enable {
    programs.zen-browser = {
      enable = true;
      policies =
        let
          mkLockedAttrs = builtins.mapAttrs (
            _: value: {
              Value = value;
              Status = "locked";
            }
          );
          mkExtensionSettings = builtins.mapAttrs (
            _: pluginId: {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
              installation_mode = "force_installed";
            }
          );
        in
        {
          # keep-sorted start block=yes
          AutofillCreditCardEnabled = false;
          EnableTrackingProtection = {
            Value = true;
            Category = "strict";
          };
          ExtensionSettings = mkExtensionSettings {
            "uBlock0@raymondhill.net" = "ublock-origin";
            "{446900e4-71c2-419f-a6a7-df9c091e268b}" = "bitwarden-password-manager";
            "sponsorBlocker@ajay.app" = "sponsor-block";
            "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = "return-youtube-dislikes";
            "deArrow@ajay.app" = "dearrow";
          };
          HttpsOnlyMode = "enabled";
          NoDefaultBookmarks = true;
          OfferToSaveLogins = false;
          Preferences = mkLockedAttrs {
            "intl.accept_languages" = "en-AU,en-GB,en-US,en";
            "general.autoScroll" = true;
            # disable google safebrowsing
            "browser.safebrowsing.malware.enabled" = false;
            "browser.safebrowsing.phishing.enabled" = false;
            "browser.warnOnQuit" = false;
            "browser.tabs.warnOnClose" = false;
            # continue where you left off
            "browser.startup.page" = 3;
          };
          RequestedLocales = [
            "en-AU"
            "en-GB"
            "en-US"
          ];
          SearchEngines = {
            Default = "duckduckgo";
            DefaultPrivate = "duckduckgo";
          };
          SearchSuggestEnabled = true;
          # keep-sorted end
        };
    };
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
