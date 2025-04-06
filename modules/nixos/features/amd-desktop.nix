{ config, lib, pkgs, ... }:
let
  feature = "amd-desktop";
  cfg = config.${feature};

in {
  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";

  config = lib.mkIf cfg.enable {

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
        cameractrls-gtk3
        ghostty
        kiwix
        obsidian
        signal-desktop
        vlc
        vscode
      ] ++ (with pkgs.kdePackages; [ skanlite ktorrent calligra kzones ]);

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
}
