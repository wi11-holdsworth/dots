{ config, lib, pkgs, ... }:
let
  # declare the module name and its local module dependencies
  feature = "amd-desktop";
  dependencies = with config; [ core ];

  # helper functions
  dependenciesEnabled = lib.all (dep: dep.enable) dependencies;
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled && dependenciesEnabled;

in {
  config = lib.mkIf enabled {

    # load graphics drivers before anything else
    boot.initrd.kernelModules = [ "amdgpu" ];

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [ amdvlk ];
    };

    environment.systemPackages = with pkgs;
      [
        brave
        calibre
        cameractrls-gtk3
        ghostty
        jellyfin-media-player
        kiwix
        libreoffice
        nixfmt-rfc-style
        obsidian
        signal-desktop
        vlc
        vscode
      ] ++ (with pkgs.kdePackages; [ skanlite ktorrent kzones ]);

    security.rtkit.enable = true;

    services = {
      desktopManager.plasma6.enable = true;
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
      pipewire = {
        alsa.enable = true;
        alsa.support32Bit = true;
        enable = true;
        jack.enable = true;
        pulse.enable = true;
      };
      xserver.videoDrivers = [ "amdgpu" ];
    };
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
