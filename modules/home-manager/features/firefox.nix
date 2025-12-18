{
  pkgs,
  ...
}:
{
  programs.firefox = {
    enable = true;
    languagePacks = [ "en-GB" ];
    profiles.will = {
      settings = {
        # keep-sorted start
        "browser.aboutwelcome.enabled" = false;
        "browser.bookmarks.addedImportButton" = false;
        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.newtabpage.enabled" = false;
        "browser.safebrowsing.downloads.enabled" = false;
        "browser.safebrowsing.malware.enabled" = false;
        "browser.safebrowsing.phishing.enabled" = false;
        "browser.safebrowsing.remote.block_potentially_unwanted" = false;
        "browser.safebrowsing.remote.block_uncommon" = false;
        "browser.search.suggest.enabled" = false;
        "browser.startup.homepage" = "chrome://browser/content/blanktab.html";
        "browser.startup.page" = 3;
        "browser.tabs.groups.smart.userEnabled" = false;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.urlbar.suggest.searches" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.usage.uploadEnabled" = false;
        "dom.security.https_only_mode" = true;
        "dom.security.https_only_mode_ever_enabled" = true;
        "extensions.formautofill.creditCards.enabled" = false;
        "general.autoScroll" = true;
        "intl.locale.requested" = "en-GB";
        "network.trr.mode" = 3;
        "network.trr.uri" = "https://firefox.dns.nextdns.io/";
        "privacy.annotate_channels.strict_list.enabled" = true;
        "privacy.bounceTrackingProtection.mode" = 1;
        "privacy.clearOnShutdown_v2.formdata" = true;
        "privacy.fingerprintingProtection" = true;
        "privacy.globalprivacycontrol.enabled" = true;
        "privacy.globalprivacycontrol.was_ever_enabled" = true;
        "privacy.query_stripping.enabled " = true;
        "privacy.query_stripping.enabled.pbmode" = true;
        "privacy.trackingprotection.allow_list.baseline.enabled" = true;
        "privacy.trackingprotection.allow_list.convenience.enabled" = false;
        "privacy.trackingprotection.consentmanager.skip.pbmode.enabled" = false;
        "privacy.trackingprotection.emailtracking.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "sidebar.main.tools" = "syncedtabs,history,bookmarks";
        "sidebar.new-sidebar.has-used" = true;
        "sidebar.position_start" = false;
        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;
        "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;
        "signon.autofillForms" = false;
        "signon.firefoxRelay.feature" = "disabled";
        "signon.generation.enabled" = false;
        "signon.management.page.breach-alerts.enabled" = false;
        "signon.rememberSignons" = false;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        # keep-sorted end
      };
      search = {
        default = "ddg";
        privateDefault = "ddg";
        engines = { };
        order = [ ];
        force = true;
      };
      extensions = {
        force = true;
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          # keep-sorted start sticky_comments=no
          # detect-cloudflare
          bitwarden
          dearrow
          floccus
          nixpkgs-pr-tracker
          react-devtools
          return-youtube-dislikes
          sponsorblock
          ublock-origin
          # keep-sorted end
        ];
        settings = {
          # keep-sorted start block=yes
          # sponsorblock
          "sponsorBlocker@ajay.app".settings = {
              hideSegmentCreationInPopup = false;
              autoSkipOnMusicVideosUpdate = true;
              changeChapterColor = true;
              autoSkipOnMusicVideos = false;
              hideVideoPlayerControls = false;
              useVirtualTime = true;
              categoryPillColors = { };
              payments = {
                chaptersAllowed = false;
                freeAccess = false;
                lastCheck = 0;
                lastFreeCheck = 0;
                licenseKey = null;
              };
              allowExpirements = true;
              allowScrollingToEdit = true;
              audioNotificationOnSkip = false;
              autoHideInfoButton = true;
              categoryPillUpdate = true;
              chapterCategoryAdded = true;
              checkForUnlistedVideos = false;
              cleanPopup = false;
              darkMode = true;
              deArrowInstalled = true;
              defaultCategory = "chooseACategory";
              disableSkipping = false;
              donateClicked = 0;
              dontShowNotice = false;
              forceChannelCheck = false;
              fullVideoLabelsOnThumbnails = true;
              fullVideoSegments = true;
              hideDeleteButtonPlayerControls = false;
              hideDiscordLaunches = 0;
              hideDiscordLink = false;
              hideInfoButtonPlayerControls = false;
              hideSkipButtonPlayerControls = false;
              hideUploadButtonPlayerControls = false;
              categorySelections = [
                {
                  name = "sponsor";
                  option = 2;
                }
                {
                  name = "poi_highlight";
                  option = 1;
                }
                {
                  name = "exclusive_access";
                  option = 0;
                }
                {
                  name = "chapter";
                  option = 0;
                }
                {
                  name = "selfpromo";
                  option = 1;
                }
                {
                  name = "interaction";
                  option = 1;
                }
                {
                  name = "intro";
                  option = 1;
                }
                {
                  name = "outro";
                  option = 1;
                }
                {
                  name = "preview";
                  option = 1;
                }
                {
                  name = "filler";
                  option = 1;
                }
                {
                  name = "music_offtopic";
                  option = 2;
                }
                {
                  name = "hook";
                  option = 1;
                }
              ];
              manualSkipOnFullVideo = false;
              minDuration = 0;
              isVip = false;
              muteSegments = false;
              noticeVisibilityMode = 3;
              renderSegmentsAsChapters = false;
              scrollToEditTimeUpdate = false;
              serverAddress = "https://sponsor.ajay.app";
              showAutogeneratedChapters = false;
              showCategoryGuidelines = true;
              showCategoryWithoutPermission = false;
              showChapterInfoMessage = true;
              showDeArrowInSettings = true;
              showDeArrowPromotion = true;
              showDonationLink = false;
              showNewFeaturePopups = false;
              showSegmentFailedToFetchWarning = true;
              showSegmentNameInChapterBar = true;
              showTimeWithSkips = true;
              showUpcomingNotice = false;
              showUpsells = false;
              minutesSaved = 67.630516;
              shownDeArrowPromotion = false;
              showZoomToFillError2 = false;
              skipNoticeDuration = 4;
              sponsorTimesContributed = 0;
              testingServer = false;
              trackDownvotes = false;
              trackDownvotesInPrivate = false;
              trackViewCount = false;
              trackViewCountInPrivate = false;
              ytInfoPermissionGranted = false;
              skipNonMusicOnlyOnYoutubeMusic = false;
              hookUpdate = false;
              permissions = {
                sponsor = true;
                selfpromo = true;
                exclusive_access = true;
                interaction = true;
                intro = true;
                outro = true;
                preview = true;
                hook = true;
                music_offtopic = true;
                filler = true;
                poi_highlight = true;
                chapter = false;
              };
              segmentListDefaultTab = 0;
              prideTheme = false;
            };
          # ublock-origin
          "uBlock0@raymondhill.net".settings = {
            advancedUserEnabled = true;
            selectedFilterLists = [
              "user-filters"
              "ublock-filters"
              "ublock-badware"
              "ublock-privacy"
              "ublock-quick-fixes"
              "ublock-unbreak"
              "easylist"
              "easyprivacy"
              "adguard-spyware-url"
              "urlhaus-1"
              "plowe-0"
            ];
          };
          # keep-sorted end
        };
      };
    };
  };
}
